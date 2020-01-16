#!/bin/sh

######################################
# vscode
######################################

desktopdir=~/.local/share/applications

mkdir -p $desktopdir

rm /tmp/code.desktop

echo "[Desktop Entry]" >> /tmp/code.desktop
echo "Version=1.0" >> /tmp/code.desktop
echo "Type=Application" >> /tmp/code.desktop
echo "Name=Visual Studio Code" >> /tmp/code.desktop
echo "Icon=${HOME}/dotfiles/icons/code.png" >> /tmp/code.desktop
echo "Exec=code" >> /tmp/code.desktop
echo "Comment=Develop with pleasure!" >> /tmp/code.desktop
echo "Categories=Development;IDE;" >> /tmp/code.desktop
echo "Terminal=false" >> /tmp/code.desktop

desktop-file-install --dir=$HOME/.local/share/applications /tmp/code.desktop
update-desktop-database $HOME/.local/share/applications
