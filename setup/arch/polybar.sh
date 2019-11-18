#!/bin/sh

git clone https://aur.archlinux.org/polybar.git /tmp/polybar-src
cd /tmp/polybar-src
makepkg -si --noconfirm
cd -
rm -rf /tmp/polybar-src

mkdir -p $HOME/.config/polybar
install -Dm644 /usr/share/doc/polybar/config $HOME/.config/polybar/config

