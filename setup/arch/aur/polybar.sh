#!/bin/sh

git clone https://aur.archlinux.org/polybar.git /tmp/polybar-aur
cd /tmp/polybar-aur
makepkg -si --noconfirm
cd -

