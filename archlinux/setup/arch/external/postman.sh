#!/bin/sh

######################################
# postman
######################################

installdir=~/.local/opt/Postman
desktopdir=~/.local/share/applications

mkdir -p $desktopdir
mkdir -p $installdir

downloadurl="https://dl.pstmn.io/download/latest/linux64"

if [ ! -f /tmp/postman.tar.gz ]; then
    curl -o /tmp/postman.tar.gz -L $downloadurl
fi

cd /tmp
tar -zxf /tmp/postman.tar.gz
rm -rf $installdir/*
mv /tmp/Postman/* $installdir
cd -


# launcher
if [ -f /tmp/postman.desktop ]; then
    rm /tmp/postman.desktop
fi

echo "[Desktop Entry]" >> /tmp/postman.desktop
echo "Name=Postman" >> /tmp/postman.desktop
echo "Type=Application" >> /tmp/postman.desktop
echo "Exec=Postman" >> /tmp/postman.desktop
echo "Icon=${HOME}/dotfiles/icons/postman.png" >> /tmp/postman.desktop
echo "Terminal=false" >> /tmp/postman.desktop

desktop-file-install --dir=$HOME/.local/share/applications /tmp/postman.desktop
update-desktop-database $HOME/.local/share/applications
