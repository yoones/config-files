#!/usr/bin/env ruby
# coding: utf-8

already_played = []

while true
  titles = `wmctrl -l | grep Firefox | cut -d ' ' -f 5- | sed 's/ - Spotify - Mozilla Firefox//g'`.split("\n")
  title = ""
  titles.each do |t|
    if t[0] == "▶"
      title = t
      break
    end
  end
  if title[0] != "▶"
    `pkill pacat`
    sleep 0.1
    next
  end
  title.gsub!("▶ ", "")
  if already_played.include?(title)
    sleep 0.1
  else
    puts title
    `pkill pacat`
    already_played << title
    pid = spawn("./spotify-recorder.sh \"#{title}\"")
    Process.detach(pid)
  end
end
