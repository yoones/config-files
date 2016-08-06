#!/bin/bash

# sudo apt-get install libsox-fmt-mp3
# pacmd list-sources | grep 'name:' | grep output | cut -d '<' -f 2 | cut -d '>' -f 1

output_dir="outputs"

mkdir -p $output_dir
pacat --record -d alsa_output.pci-0000_00_1b.0.analog-stereo.monitor | sox -t raw -r 44100 -s -L -b 16 -c 2 - "$output_dir/$1.wav"
