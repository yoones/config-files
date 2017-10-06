#!/bin/bash

if [ "$USERNAME" == "root" ]; then
    echo "You should not run this script as root"
    exit 1
fi

if ! which sudo > /dev/null; then
    su root -c "sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list"
    su root -c "apt-get update && apt-get install sudo && usermod -G sudo $USERNAME"
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
sudo apt-get dist-upgrade -y

# install default packages
sudo apt-get install -y emacs vlc htop gcc g++ build-essential nmap most \
     make binutils git unzip unrar valgrind gdb gimp tree gnome-tweak-tool \
     flashplugin-nonfree firmware-iwlwifi pdfmod \
     soundconverter colordiff

mkdir -p ~/personal ~/projects/fu/current_task

cd ~/projects/
git clone https://github.com/yoones/config-files.git
cd config-files
ln -s $HOME/projects/config-files/my $HOME/.my
cp bashrc ~/.bashrc
cp emacs ~/.emacs
cp -r emacs.d ~/.emacs.d
cp gitconfig ~/.gitconfig
cp gitignore ~/.gitignore
cp hd_playlist.m3u ~/.hd_playlist.m3u
cp mimeapps.list ~/.config/mimeapps.list
bash < ./dconf_shortcuts
dconf load /org/gnome/terminal/legacy/profiles:/ < ./gnome_term_config

cd ~/projects
git clone https://github.com/yoones/railsondeb.git
cd railsondeb
./railsondeb install
