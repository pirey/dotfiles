#!/bin/sh

remove_file () {
    if [ ! -e "$1" ]; then
        echo "File $1 doesn't exists"
    else
        rm -rf "$1"
    fi
}

echo "-> removing files..."

# TODO get file names dynamically
remove_file ~/.config/i3
remove_file ~/.config/i3status
remove_file ~/.config/volumeicon
remove_file ~/.config/rofi
remove_file ~/.config/picom

echo "OK files removed"

