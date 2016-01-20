#!/usr/bin/env ruby

## Helper(s)
def usage
  $stderr.puts "Usage: ldiff file1 file2"
  $stderr.puts "  -h: Display this usage"
  $stderr.puts "  -m: Display matches"
  $stderr.puts "  -d1: Display not-matching items of file1"
  $stderr.puts "  -d2: Display not-matching items of file2"
end

## Command-line arguments
opt = ""
case ARGV.count
when 2
  opt = "d1,d2"
  f1 = ARGV[0]
  f2 = ARGV[1]
when 3
  f1 = ARGV[1]
  f2 = ARGV[2]
  case ARGV[0]
  when "-h"
    usage
    exit 0
  when "-m"
    opt = "m"
  when "-d1"
    opt = "d1"
  when "-d2"
    opt = "d2"
  else
    $stderr.puts "Unknown option #{ARGV[0]}"
    usage
    exit 1
  end
else
  usage
  exit 1
end

## Read both files
fd1 = File.open(f1) or die "Error: open(#{f1}) failed"
fd2 = File.open(f2) or die "Error: open(#{f2}) failed"
fd1_arr = fd1.readlines { |line| }
fd2_arr = fd2.readlines { |line| }
fd1.close
fd2.close

##--- start real work
case opt
when "m"
  arr = fd1_arr & fd2_arr
  arr.each { |line| puts line }
when "d1"
  arr = fd1_arr - fd2_arr
  arr.each { |line| puts line }
when "d2"
  arr = fd2_arr - fd1_arr
  arr.each { |line| puts line }
when "d1,d2"
  puts "-> file1: #{f1}"
  arr = fd1_arr - fd2_arr
  arr.each { |line| puts line }
  puts "---"
  puts "-> file2: #{f2}"
  arr = fd2_arr - fd1_arr
  arr.each { |line| puts line }
  puts "---"
else
  $stderr.puts "DBG: unknown option"
end

exit 0
