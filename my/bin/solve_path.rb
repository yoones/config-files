#!/usr/bin/env ruby

unless ARGV.count > 1
  $stderr.puts "Usage: solve_path.rb <root_path> <subdir1> [subdir2] [..]"
  exit 1
end

root_path = ARGV.shift
paths = Dir.glob([root_path, ARGV.collect { |i| "#{i}*" }].flatten.join('/'))
exit 1 if paths.count == 0
puts paths.first
exit 0
