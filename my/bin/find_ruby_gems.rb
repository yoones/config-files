#!/usr/bin/env ruby

def cd(path = "")
  ret = false
  if path == ""
    ret = Dir.chdir
  else
    ret = Dir.chdir(path)
  end
  exit 1 if ret == false
end

cd
cd ".rbenv/versions"
version = `ls -dt * | head -n 1 | tr -d '\n'`
cd version
cd "lib/ruby/gems"
version = `ls -dt * | head -n 1 | tr -d '\n'`
cd version
cd "gems"

puts Dir.pwd

exit 0
