#!/usr/bin/env ruby

def print_usage
  $stderr.puts "Usage:"
  $stderr.puts "mv-files --add-prefix prefix [*.txt]"
  $stderr.puts "mv-files --add-suffix prefix [*.txt]"
  $stderr.puts "mv-files --replace old-word new-word [*.txt]"
  $stderr.puts ""
  $stderr.puts "Example:"
  $stderr.puts "mv-files --replace 'txt$' 'csv' ./*.txt"
end

def err
  $stderr.puts "Error: bad arguments"
  print_usage()
  exit 1
end

err if ARGV.count < 2

def proceed_check(files)
  if files.count == 0
    $stderr.puts "No file found"
    exit 1
  end
  files.each do |f|
    puts f
  end
  puts ""
  puts "Proceed? (y/n) "
  a = $stdin.readline
  a.gsub!("\n", "")
  if a != "y"
    $stderr.puts "Abort."
    exit 1
  end
end

case ARGV[0]
## --add-prefix
when "--add-prefix"
  prefix = ARGV[1]
  g = "*"
  if ARGV.count == 3
    g = ARGV[2]
  elsif ARGV.count > 3
    err
  end
  files = Dir.glob(g)
  proceed_check(files)
  files.each do |f|
    File.rename(f, "#{prefix}#{f}")
  end

## --add-suffix
when "--add-suffix"
  suffix = ARGV[1]
  g = "*"
  if ARGV.count == 3
    g = ARGV[2]
  elsif ARGV.count > 3
    err
  end
  files = Dir.glob(g)
  if files.count == 0
    puts "No file found"
    exit 0
  end
  proceed_check(files)
  files.each do |f|
    File.rename(f, "#{f}#{suffix}")
  end

## --replace
when "--replace"
  old_word = ARGV[1]
  new_word = ARGV[2]
  g = "*"
  if ARGV.count == 4
    g = ARGV[3]
  elsif ARGV.count > 4
    err
  end
  files = Dir.glob(g)
  proceed_check(files)
  files.each do |f|
    File.rename(f, f.gsub(old_word, new_word))
  end
end

exit 0
