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
mv /tmp/Postman $installdir
cd -

cat << 'POSTMAN' > /tmp/postman.desktop
[Desktop Entry]
Name=Postman
Type=Application
Exec=Postman
POSTMAN

desktop-file-install --dir=$HOME/.local/share/applications /tmp/postman.desktop
update-desktop-database $HOME/.local/share/applications
