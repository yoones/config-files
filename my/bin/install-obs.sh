#!/bin/bash

ROOTPATH="$HOME/.obs-studio"
SOURCES="$ROOTPATH/sources"

function install_dependencies()
{
    sudo apt-get install -y build-essential pkg-config cmake git checkinstall \
	 \
	 libx11-dev libgl1-mesa-dev libpulse-dev libxcomposite-dev \
	 libxinerama-dev libv4l-dev libudev-dev libfreetype6-dev \
	 libfontconfig-dev qtbase5-dev libqt5x11extras5-dev libx264-dev \
	 libxcb-xinerama0-dev libxcb-shm0-dev libjack-jackd2-dev libcurl4-openssl-dev \
	 \
	 zlib1g-dev yasm \
	 cmake mercurial \
	 libtheora-dev \
	 libvorbis-dev \
	 libfdk-aac-dev \
	 libmp3lame-dev \
	 libopus-dev \
	 libass-dev \
	 libfdk-aac-dev
}

function compile_and_install_libx265()
{
    cd $SOURCES
    hg clone https://bitbucket.org/multicoreware/x265
    cd $SOURCES/x265/build/linux
    cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=/usr -DENABLE_SHARED:bool=on ../../source
    make
    sudo checkinstall --pkgname=libx265 --fstrans=no --backup=no \
    	 --pkgversion="$(date +%Y%m%d)-git" --deldoc=yes
    make clean
}

function compile_and_install_libvpx()
{
    cd $ROOTPATH
    wget http://storage.googleapis.com/downloads.webmproject.org/releases/webm/libvpx-1.5.0.tar.bz2
    tar xjvf libvpx-1.5.0.tar.bz2
    cd libvpx-1.5.0
    ./configure \
	--prefix=/usr \
	--enable-shared \
	--enable-pic \
	--disable-examples \
	--disable-unit-tests
    make
    sudo checkinstall --pkgname=libvpx --fstrans=no --backup=no \
    	 --pkgversion="$(date +%Y%m%d)-git" --deldoc=yes
    make clean
}

function compile_and_install_ffmpeg()
{
    cd $SOURCES
    wget http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
    tar xjvf ffmpeg-snapshot.tar.bz2
    cd ffmpeg
    ./configure \
	--prefix=/usr \
	--enable-shared \
	--enable-pic \
	--enable-gpl \
	--enable-libass \
	--enable-libfdk-aac \
	--enable-libfreetype \
	--enable-libmp3lame \
	--enable-libopus \
	--enable-libtheora \
	--enable-libvorbis \
	--enable-libvpx \
	--enable-libx264 \
	--enable-libx265 \
	--enable-nonfree
    make
    sudo checkinstall --pkgname=ffmpeg --fstrans=no --backup=no \
    	 --pkgversion="$(date +%Y%m%d)-git" --deldoc=yes
    make distclean
    hash -r
}

function compile_and_install_obs_studio()
{
    cd $SOURCES
    # git clone --depth 1 https://github.com/jp9000/obs-studio.git
    git clone --depth 1 https://github.com/yoones/obs-studio.git
    cd obs-studio
    mkdir -p build && cd build
    cmake -DUNIX_STRUCTURE=1 -DCMAKE_INSTALL_PREFIX=/usr ..
    make -j4
    sudo checkinstall --pkgname=obs-studio --fstrans=no --backup=no \
    	 --pkgversion="$(date +%Y%m%d)-git" --deldoc=yes
}

function main()
{
    if [ -d $ROOTPATH ]; then
    	echo Directory already exists, aborting to prevent data loss/corruption > /dev/stderr
    	exit 1
    fi
    mkdir -p -- "$ROOTPATH"
    mkdir -p -- "$SOURCES"

    pushd . > /dev/null 2> /dev/null

    ORANGE='\033[0;33m'
    NC='\033[0m'

    printf "${ORANGE}*** Install dependencies...${NC}\n"
    install_dependencies

    printf "${ORANGE}*** Compile and install libx265${NC}\n"
    compile_and_install_libx265

    printf "${ORANGE}*** Compile and install libvpx${NC}\n"
    compile_and_install_libvpx

    printf "${ORANGE}*** Compile and install ffmpeg${NC}\n"
    compile_and_install_ffmpeg

    printf "${ORANGE}*** Compile and install obs-studio${NC}\n"
    compile_and_install_obs_studio

    printf "${ORANGE}*** Done.${NC}\n"

    popd > /dev/null 2> /dev/null
}

set -e
main
