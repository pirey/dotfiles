#!/bin/sh

######################################
# android file transfer
######################################

currentscript=$(realpath $0)
archdir=$(dirname $currentscript)
setupdir=$(dirname $archdir)

sudo -S pacman --noconfirm -Syu android-file-transfer android-udev
