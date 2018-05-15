#!/usr/bin/env ruby

sep = ';'
if ARGV.first == "-d" && ARGV[1].length == 1
  sep = ARGV[1]
  2.times { ARGV.shift }
end

if ARGV.count != 1
  $stderr.puts <<EOF
Usage: csv_swap_fields.rb [-d 'c'] <order>
  -d    : Delimiter (a single char). Default value: ";"
  order : First field's index is 1 (not 0). Example: "1,4,3,2"
EOF
  exit 1
end

fields = ARGV.first.split(sep).map { |i| i.to_i }

while line = $stdin.gets
  f = line.chomp.split(sep)
  puts fields.collect { |idx| f[idx - 1] }.join(sep)
end

exit 0
