#!/bin/sh

echo "======================================"
echo "Installing Extra packages..."
echo "======================================"

currentscript=$(realpath $0)
archdir=$(dirname $currentscript)
setupdir=$(dirname $archdir)


sudo -S pacman --noconfirm -Syu chromium \
    firefox \
    lxappearance \
    arc-gtk-theme \
    arc-icon-theme \
    vlc \
    cmus \
    mpd \
    ncmpcpp \
    libreoffice-still \
    gimp \
    inkscape \
    pcmanfm \
    viewnior \
    gnome-system-monitor
    # gimp-help-en \
