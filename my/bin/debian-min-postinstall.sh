#!/bin/bash

set -e

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
     make binutils gcc git unzip valgrind gdb gimp tree gnome-tweak-tool \
     pdfmod \
     mosh
# for dell xps 13: firmware-atheros intel-microcode
# firmware-iwlwifi
# flashplugin-nonfree
sudo apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common dirmngr
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -
sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce
if [ ! -f "/usr/local/bin/docker-compose" ]; then
    sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

mkdir -p ~/personal ~/projects/fu/current_task

cd ~/projects/
if [ ! -d "./config-files" ]; then
    git clone https://github.com/yoones/config-files.git
fi
cd config-files
if [ ! -L "$HOME/.my" ]; then
    ln -s $HOME/projects/config-files/my $HOME/.my
fi
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
if [ ! -d "./railsondeb" ]; then
    git clone https://github.com/yoones/railsondeb.git
fi
cd railsondeb
./railsondeb install
