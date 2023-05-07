#!/bin/sh

# install dependency manually
sudo -S pacman --noconfirm -Syu slop
git clone https://aur.archlinux.org/python2-distutils-extra.git /tmp/python2-distutils-extra
git clone https://aur.archlinux.org/screenkey.git /tmp/screenkey-aur

cd /tmp/python2-distutils-extra
makepkg -si --noconfirm

cd /tmp/polybar-aur
makepkg -si --noconfirm
cd -

