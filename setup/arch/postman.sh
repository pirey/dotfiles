#!/bin/sh

######################################
# postman
######################################

currentscript=$(realpath $0)
archdir=$(dirname $currentscript)
setupdir=$(dirname $archdir)
installdir=~/.local/opt/Postman
desktopdir=~/.local/share/applications

mkdir -p $desktopdir
mkdir -p $installdir

downloadurl="https://dl.pstmn.io/download/latest/linux64"

curl -o /tmp/postman.tar.gz -L $downloadurl
tar -zxf /tmp/postman.tar.gz
mv /tmp/postman $installdir

cat << 'POSTMAN' > /tmp/postman.desktop
[Desktop Entry]
Name=Postman
Type=Application
Exec=Postman
POSTMAN

desktop-file-install --dir=$HOME/.local/share/applications /tmp/postman.desktop
update-desktop-database $HOME/.local/share/applications