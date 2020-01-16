#!/bin/sh

# fonts

currentscript=$(realpath $0)
archdir=$(dirname $currentscript)
setupdir=$(dirname $archdir)
dotfilesdir=$(dirname $setupdir)

sudo pacman -S ttf-fantasque-sans-mono

mkdir -p ~/.local/share/fonts
cp $dotfilesdir/fonts/* ~/.local/share/fonts
fc-cache
