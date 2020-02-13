#!/bin/sh

echo "======================================"
echo "Installing fonts..."
echo "======================================"

currentscript=$(realpath $0)
archdir=$(dirname $currentscript)
setupdir=$(dirname $archdir)
dotfilesdir=$(dirname $setupdir)

sudo pacman -S ttf-fantasque-sans-mono \
    ttf-jetbrains-mono \
    powerline-fonts \
    ttf-nerd-fonts-symbols

mkdir -p ~/.local/share/fonts
cp $dotfilesdir/fonts/* ~/.local/share/fonts
fc-cache
