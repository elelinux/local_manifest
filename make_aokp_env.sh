#!/bin/bash

cd ~/
echo "Which dir to repo init in? (~/aokp/<dir name>)"
read dir


sudo apt-get install git-core gnupg flex bison gperf build-essential zip \
             curl libc6-dev libncurses5-dev:i386 x11proto-core-dev libx11-dev:i386 \
             libreadline6-dev:i386 libgl1-mesa-glx:i386 libgl1-mesa-dev g++-multilib \
             mingw32 openjdk-6-jdk tofrodos python-markdown schedtool pngcrush libxml2-utils \
             xsltproc zlib1g-dev:i386
sudo ln -s /usr/lib/i386-linux-gnu/mesa/libGL.so.1 /usr/lib/i386-linux-gnu/libGL.so
mkdir bin
export PATH=~/bin:$PATH
curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
mkdir aokp
mkdir aokp/$dir
cd aokp/$dir
repo init -u https://github.com/AOKP/platform_manifest.git -b kitkat -g all,kernel,device,vendor
repo sync -j32
