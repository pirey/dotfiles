#!/bin/sh

######################################
# lite
######################################

installdir=~/.local/opt/lite
desktopdir=~/.local/share/applications

mkdir -p $desktopdir
mkdir -p $installdir

downloadurl="https://github.com/rxi/lite/releases/download/v1.11/lite.zip"

if [ ! -f /tmp/lite.zip ]; then
    curl -o /tmp/lite.zip -L $downloadurl
fi

cd /tmp
unzip /tmp/lite.zip -d /tmp/lite
rm -rf $installdir/*
mv /tmp/lite/* $installdir
cd -


# launcher

if [ -f /tmp/lite.desktop ]; then
    rm /tmp/lite.desktop
fi

echo "[Desktop Entry]" >> /tmp/lite.desktop
echo "Version=1.0" >> /tmp/lite.desktop
echo "Type=Application" >> /tmp/lite.desktop
echo "Name=Lite" >> /tmp/lite.desktop
echo "Icon=${HOME}/dotfiles/icons/lite.ico" >> /tmp/lite.desktop
echo "Exec=lite" >> /tmp/lite.desktop
echo "Comment=Develop with pleasure!" >> /tmp/lite.desktop
echo "Categories=Development;IDE;" >> /tmp/lite.desktop
echo "Terminal=false" >> /tmp/lite.desktop

desktop-file-install --dir=$HOME/.local/share/applications /tmp/lite.desktop
update-desktop-database $HOME/.local/share/applications
