#!/bin/sh

echo "======================================"
echo "Installing fonts..."
echo "======================================"

currentscript=$(realpath $0)
archdir=$(dirname $currentscript)
setupdir=$(dirname $archdir)
dotfilesdir=$(dirname $setupdir)

sudo pacman -Syu gucharmap \
    fontforge \
    ttf-jetbrains-mono \
    ttf-nerd-fonts-symbols \
    powerline-fonts

mkdir -p ~/.local/share/fonts
cp $dotfilesdir/fonts/* ~/.local/share/fonts
fc-cache
