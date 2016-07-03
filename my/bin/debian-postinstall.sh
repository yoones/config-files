#!/bin/bash

sudo cat > /etc/apt/sources.list <<EOF
deb http://ftp.fr.debian.org/debian/ jessie main contrib non-free
deb-src http://ftp.fr.debian.org/debian/ jessie main contrib non-free

deb http://security.debian.org/ jessie/updates main
deb-src http://security.debian.org/ jessie/updates main

deb http://ftp.fr.debian.org/debian/ jessie-updates main
deb-src http://ftp.fr.debian.org/debian/ jessie-updates main
EOF

# update/upgrade system
sudo apt-get update
sudo apt-get dist-upgrade

# install default packages
sudo apt-get install emacs vlc htop gcc g++ build-essential nmap most make binutils \
     git unzip unrar valgrind gdb gimp tree gnome-tweak-tool

mkdir -p ~/personal ~/projects

cd ~/projects/
git clone https://github.com/yoones/config-files.git
cd config-files
cp -r my ~/.my
cp bashrc ~/.bashrc
cp gitconfig ~/.gitconfig
cp mimeapps.list ~/.config/mimeapps.list
bash < ./dconf_shortcuts
dconf load /org/gnome/terminal/legacy/profiles:/ < ./gnome_term_config

cd ~/projects
git clone https://github.com/yoones/railsondeb.git
cd railsondeb
./railsondeb install
