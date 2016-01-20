#!/usr/bin/env ruby

if ARGV.count == 0 || (ARGV.count == "1" && ARGV[0] == "--help")
  $stderr.puts <<EOF
Usage: csvql [-v] "condition1" ["condition2"] [...]
Print matching lines from standard input to standard output.

configuration:
  -v : verbose mode (display matching fields in addition to matching lines)
  -q : quiet mode (display only matching lines)

condition:
  [field index] operator value

operators:
  == != <= >= < > include: exclude: match_line_in_file: doesnt_match_line_in_file:

Example:
csvql "[1]>=12" "[2]include:HelloWorld!" "[4]match_line_in_file:/tmp/whitelist.txt

First field's index is 1 (not 0).
EOF
  exit 1
end

def op_equal(data, value)
  data == value
end

def op_not_equal(data, value)
  data != value
end

def op_less_or_equal_to(data, value)
  data.to_i <= value.to_i
end

def op_greater_or_equal_to(data, value)
  data.to_i >= value.to_i
end

def op_less_than(data, value)
  data.to_i < value.to_i
end

def op_greater_than(data, value)
  data.to_i > value.to_i
end

def op_include(data, value)
  data.include?(value)
end

def op_exclude(data, value)
  !data.include?(value)
end

def op_match_line_in_file(data, value)
  fd = File.open(value) or die "Error: open(#{file}) failed"
  fd.readlines.each do |line|
    if line.gsub("\n", "") == data
      fd.close
      return true
    end
  end
  fd.close
  false
end

def op_doesnt_match_line_in_file(data, value)
  !op_in_file(data, value)
end

operators = {
  "=="                         => {func: method(:op_equal),                     value: ".*"},
  "!="                         => {func: method(:op_not_equal),                 value: ".*"},
  "<="                         => {func: method(:op_less_or_equal_to),          value: ".*"},
  ">="                         => {func: method(:op_greater_or_equal_to),       value: ".*"},
  "<"                          => {func: method(:op_less_than),                 value: "[0-9]*"},
  ">"                          => {func: method(:op_greater_than),              value: "[0-9]*"},
  "include:"                   => {func: method(:op_include),                   value: ".*"},
  "exclude:"                   => {func: method(:op_exclude),                   value: ".*"},
  "match_line_in_file:"        => {func: method(:op_match_line_in_file),        value: ".*"},
  "doesnt_match_line_in_file:" => {func: method(:op_doesnt_match_line_in_file), value: ".*"},
}

## STEP 1 : read configuration and conditions from ARGV

conditions = []
verbose = false

ARGV.each do |c|
  ## Configuration
  if c == "-v" || c == "--verbose"
    verbose = true
  elsif c == "-q" || c == "--quiet"
    verbose = false
  else
    ## Condition
    scan_result = c.scan(/^\[([0-9]*)\].*$/)
    index = (scan_result.nil? || scan_result.last.nil?) ? nil : scan_result.last.first
    if index.nil? || index == ""
      $stderr.puts "Error: bad index"
      exit 1
    end
    index = index.to_i - 1

    operator = nil
    value = nil
    operators.each do |k, v|
      unless c.scan(/^\[[0-9]*\]#{k}#{v[:value]}$/).last.nil?
        operator = k
        value = c.scan(/\[[0-9]*\]#{k}(#{v[:value]})/).last.first
      end
    end
    if operator.nil?
      $stderr.puts "Error: unknown operator"
      exit 1
    end

    conditions << {index: index, operator: operator, value: value}
  end
end

## STEP 2 : parse stdin

first_line=true
while line = $stdin.gets
  f = line.gsub("\n", "").split(';')
  display = true
  puts "" if (verbose == true && first_line == false)
  first_line = false
  puts line if verbose == true
  conditions.each do |c|
    puts "display=#{display.to_s}" if verbose == true
    func = operators[c[:operator]][:func]
    data = f[c[:index].to_i]
    value = c[:value]
    display = false unless func.call(data, value)
    if verbose == true
      puts ">> input    : \"#{data}\""
      puts ">> condition: \"#{c[:operator]}\""
      puts ">> value    : \"#{value}\""
      puts c.to_s
    end
  end
  puts "display=#{display.to_s}" if verbose == true
  puts line if display
end

exit 0
