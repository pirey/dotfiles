#!/bin/sh

git clone https://aur.archlinux.org/pgmodeler.git /tmp/pgmodeler-aur
cd /tmp/pgmodeler-aur
makepkg -si --noconfirm
cd -
