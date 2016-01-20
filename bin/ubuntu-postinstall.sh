#!/bin/bash

pushd ~

# update/upgrade system
sudo apt-get update
sudo apt-get dist-upgrade

# install default packages
sudo apt-get install emacs vlc htop dfc gcc build-essential g++ nmap most make binutils \
     tmux nasm git subversion unzip wireshark clang valgrind gdb gimp unrar

# install obs-studio
sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt-get update && sudo apt-get install obs-studio

# install docker
sudo apt-get install docker.io

# install virtualbox
# sudo apt-get install build-essential linux-headers-`uname -r` dkms
# sudo apt-get install virtualbox

# remove amazon and ubuntu one
sudo apt-get remove unity-lens-shopping
sudo apt-get autoremove --purge `dpkg -l | grep ubuntuone | cut -d \  -f 3`
rm -rf .local/share/ubuntuone/
rm -rf .cache/ubuntuone/ .config/ubuntuone/ Ubuntu\ One/
