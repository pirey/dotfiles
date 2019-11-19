#!/bin/sh

git clone https://aur.archlinux.org/screenkey.git /tmp/screenkey-aur
cd /tmp/polybar-aur
makepkg -si --noconfirm
cd -

