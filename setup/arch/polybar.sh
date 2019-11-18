#!/bin/sh

git clone https://aur.archlinux.org/polybar.git /tmp/polybar-src
cd /tmp/polybar-src
makepkg -si --noconfirm
cd -
rm -rf /tmp/polybar-src
