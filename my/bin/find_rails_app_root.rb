#!/usr/bin/env ruby

while File.exist?("Gemfile") == false && Dir.pwd != "/"
  Dir.chdir("..")
end

if File.exist?("Gemfile")
  puts Dir.pwd
  exit 0
else
  exit 1
end
