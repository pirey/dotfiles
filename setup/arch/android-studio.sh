#!/bin/sh

######################################
# android studio setup
######################################

currentscript=$(realpath $0)
archdir=$(dirname $currentscript)
setupdir=$(dirname $archdir)
installdir=~/.local/opt/android-studio

mkdir -p $installdir

sudo -S pacman --noconfirm -Syu jdk-openjdk

curl -o /tmp/android-studio.tar.gz -L https://dl.google.com/dl/android/studio/ide-zips/3.5.2.0/android-studio-ide-191.5977832-linux.tar.gz
tar -zxf /tmp/android-studio.tar.gz
mv /tmp/android-studio $installdir
