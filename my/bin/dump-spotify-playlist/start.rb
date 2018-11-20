#!/usr/bin/env ruby
# coding: utf-8

already_played = []
current_title = ""

while true
  title = `wmctrl -l | grep Firefox | grep '·' | cut -d ' ' -f 5- | sed 's/ - Spotify//g'| sed 's/ - Mozilla Firefox//g'`
  title = title.
          tr(
            'àáäâãèéëẽêìíïîĩòóöôõùúüûũñçÀÁÄÂÃÈÉËẼÊÌÍÏÎĨÒÓÖÔÕÙÚÜÛŨÑÇ·',
            'aaaaaeeeeeiiiiiooooouuuuuncAAAAAEEEEEIIIIIOOOOOUUUUUNC-'
          ).
          gsub("\n", "").
          gsub("\r", "").
          gsub(/[^[:ascii:]]/, '')
  # unless title.length == 0
  #   title.split('').each { |c| puts "(#{c}) => #{c.ord}" unless /[a-zA-Z0-9\.]/.match(c) }
  #   puts " "
  # end
  if title != current_title
    `pkill pacat`
    sleep 0.1
    # next
  end
  if already_played.include?(title)
    sleep 0.1
  else
    current_title = title
    puts title
    `pkill pacat`
    already_played << title
    pid = spawn("./spotify-recorder.sh \"#{title}\"")
    Process.detach(pid)
  end
end
