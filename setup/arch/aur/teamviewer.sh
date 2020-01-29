#!/bin/sh

git clone https://aur.archlinux.org/teamviewer.git  /tmp/teamviewer
cd /tmp/teamviewer
makepkg -si --noconfirm
cd -

