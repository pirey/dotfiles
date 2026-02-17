#!/bin/sh

######################################
# vscode
######################################

installdir=~/.local/opt/vscode
desktopdir=~/.local/share/applications

mkdir -p $desktopdir
mkdir -p $installdir

downloadurl="https://go.microsoft.com/fwlink/?LinkID=620884"

if [ ! -f /tmp/vscode.tar.gz ]; then
    curl -o /tmp/vscode.tar.gz -L $downloadurl
fi

cd /tmp
tar -zxf /tmp/vscode.tar.gz
# move previous version instead of removing it, in case the download fails
mv $installdir/* /tmp/tmp-vscode
mv /tmp/VSCode-linux-x64/* $installdir
cd -


# launcher

if [ -f /tmp/code.desktop ]; then
    rm /tmp/code.desktop
fi

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
