#!/bin/sh

git clone https://aur.archlinux.org/polybar.git /tmp/polybar-aur
cd /tmp/polybar-aur
makepkg -si --noconfirm
cd -

mkdir -p $HOME/.config/polybar
install -Dm644 /usr/share/doc/polybar/config $HOME/.config/polybar/config

