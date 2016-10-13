#!/bin/bash

if [ "$USERNAME" == "root" ]; then
    echo "You should not run this script as root"
    exit 1
fi

tmp_sources_file=$(mktemp)

cat > $tmp_sources_file <<EOF
deb http://ftp.fr.debian.org/debian/ jessie main contrib non-free
deb-src http://ftp.fr.debian.org/debian/ jessie main contrib non-free

deb http://security.debian.org/ jessie/updates main
deb-src http://security.debian.org/ jessie/updates main

deb http://ftp.fr.debian.org/debian/ jessie-updates main
deb-src http://ftp.fr.debian.org/debian/ jessie-updates main
EOF

if ! which sudo > /dev/null; then
    su root -c "cp $tmp_sources_file /etc/apt/sources.list"
    su root -c "apt-get update && apt-get install sudo && useradd -G sudo $USERNAME"
    echo Please logout/reboot and restart this script
    exit 1
fi

cat /etc/group | grep "^sudo:" | grep $USERNAME > /dev/null
if [ "$?" != "0" ]; then
    cat <<EOF 
Something is wrong. At this point, you should be in the sudo group
but you're not. Please fix it then restart this script.
If needed, reboot your computer too.

Reminder: usermod -G sudo _username_
EOF
    exit 1
fi

# update/upgrade system
sudo apt-get update
sudo apt-get dist-upgrade

# install default packages
sudo apt-get install emacs vlc htop gcc g++ build-essential nmap most \
     make binutils git unzip unrar valgrind gdb gimp tree gnome-tweak-tool \
     flashplugin-nonfree firmware-iwlwifi pdfmod nasm
     # qemu-system-x86 python3-pip

mkdir -p ~/personal ~/projects

cd ~/projects/
git clone https://github.com/yoones/config-files.git
cd config-files
ln -s . $HOME/.my
cp bashrc ~/.bashrc
cp gitconfig ~/.gitconfig
cp mimeapps.list ~/.config/mimeapps.list
bash < ./dconf_shortcuts
dconf load /org/gnome/terminal/legacy/profiles:/ < ./gnome_term_config

cd ~/projects
git clone https://github.com/yoones/railsondeb.git
cd railsondeb
./railsondeb install

# install virtualbox
sudo apt-get install build-essential linux-headers-`uname -r` dkms
sudo apt-get install virtualbox

# install obs studio
./obsondeb
