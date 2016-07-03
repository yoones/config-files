#!/usr/bin/env ruby

if ARGV.count != 1
  puts ARGV.count.to_s
  $stderr.puts <<EOF
Usage: csv_swap_fields.rb "1,4,3,2"
First field's index is 1 (not 0).
EOF
  exit 1
end

fields = ARGV.first.split(",")

while line = $stdin.gets
  f = line.gsub("\n", "").split(';')
  out = []
  fields.each do |idx|
    out << f[idx.to_i - 1]
  end
  puts out.join(";")
end

exit 0
