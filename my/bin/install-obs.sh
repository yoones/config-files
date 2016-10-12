#!/bin/bash

ROOTPATH="$HOME/.obs-studio"

function install_dependencies()
{
    sudo apt-get install -y build-essential pkg-config cmake git checkinstall

    sudo apt-get install -y libx11-dev libgl1-mesa-dev libpulse-dev libxcomposite-dev \
	 libxinerama-dev libv4l-dev libudev-dev libfreetype6-dev \
	 libfontconfig-dev qtbase5-dev libqt5x11extras5-dev libx264-dev \
	 libxcb-xinerama0-dev libxcb-shm0-dev libjack-jackd2-dev libcurl4-openssl-dev

    sudo apt-get install -y zlib1g-dev yasm \
	 cmake mercurial \
	 libfdk-aac-dev \
	 libmp3lame-dev \
	 libopus-dev \
	 libass-dev

    # sudo apt-get install libavcodec-dev libavfilter-dev libavdevice-dev libfdk-aac-dev
}

function compile_and_install_ffmpeg()
{
    cd $ROOTPATH
    mkdir -p sources
    cd sources
    wget http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
    tar xjvf ffmpeg-snapshot.tar.bz2
    cd ffmpeg
    ./configure \
	--prefix=/usr \
	--enable-shared \
	--enable-pthreads \
	--enable-gpl \
	--enable-nonfree \
	--enable-libass \
	--enable-libfreetype \
	--enable-libmp3lame \
	--enable-libopus \
	--enable-libtheora \
	--enable-libvorbis \
	--enable-libx264 \
	--enable-libfdk-aac \
    ;

    make -j4
    # sudo make install
    sudo checkinstall --pkgname=FFmpeg --fstrans=no --backup=no \
    	 --pkgversion="$(date +%Y%m%d)-git" --deldoc=yes
    # sudo make install
    # sudo make install-headers
    # sudo make install-libs
    sudo /sbin/ldconfig
}

function compile_and_instal_obs_studio()
{
    cd $ROOTPATH
    # git clone --depth 1 https://github.com/jp9000/obs-studio.git
    cd obs-studio
    mkdir -p build && cd build
    cmake -DUNIX_STRUCTURE=1 -DCMAKE_INSTALL_PREFIX=/usr ..
    make -j4
    sudo checkinstall --pkgname=obs-studio --fstrans=no --backup=no \
	 --pkgversion="$(date +%Y%m%d)-git" --deldoc=yes
}


function main()
{
    # if [ -d $ROOTPATH ]; then
    # 	echo Directory already exists, aborting to prevent data loss/corruption > /dev/stderr
    # 	exit 1
    # fi
    mkdir -p -- "$ROOTPATH"

    pushd . > /dev/null 2> /dev/null

    ORANGE='\033[0;33m'
    NC='\033[0m'

    # printf "${ORANGE}*** Compile and install FFMPEG${NC}\n"
    # compile_and_install_ffmpeg

    printf "${ORANGE}*** Compile and install OBS STUDIO${NC}\n"
    compile_and_instal_obs_studio

    printf "${ORANGE}*** Done.${NC}\n"

    popd > /dev/null 2> /dev/null
}

set -e
main
