#!/bin/sh

######################################
# android dev tools
######################################

currentscript=$(realpath $0)
archdir=$(dirname $currentscript)
setupdir=$(dirname $archdir)

mkdir -p $installdir

sudo -S pacman --noconfirm -Syu jdk-openjdk ant
