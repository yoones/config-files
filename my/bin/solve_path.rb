#!/usr/bin/env ruby

unless ARGV.count > 1
  $stderr.puts "Usage: solve_path.rb <root_path> <subdir1> [subdir2] [..]"
  exit 1
end

path = "#{ARGV.shift}/"
until ARGV.empty?
  path = Dir.glob("#{path}#{ARGV.shift}*/").first
  exit 1 if path.nil?
end
puts path
exit 0
