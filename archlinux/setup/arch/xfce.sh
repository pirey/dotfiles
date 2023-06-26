#!/bin/sh

echo "======================================"
echo "xfce related packages..."
echo "======================================"

currentscript=$(realpath $0)
archdir=$(dirname $currentscript)
setupdir=$(dirname $archdir)


sudo -S pacman --noconfirm -Syu xfce \
    xfce4-pulseaudio-plugin \
    xfce4-screenshooter \
    thunar-archive-plugin xarchiver
