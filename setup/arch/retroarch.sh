#!/bin/sh

######################################
# retroarch
######################################

currentscript=$(realpath $0)
archdir=$(dirname $currentscript)
setupdir=$(dirname $archdir)

sudo -S pacman --noconfirm -Syu retroarch libretro
