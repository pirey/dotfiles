#!/bin/sh

######################################
# android studio setup
######################################

currentscript=$(realpath $0)
archdir=$(dirname $currentscript)
setupdir=$(dirname $archdir)
installdir=~/.local/opt/android-studio
desktopdir=~/.local/share/applications

mkdir -p $desktopdir
mkdir -p $installdir

sudo -S pacman --noconfirm -Syu jdk-openjdk

curl -o /tmp/android-studio.tar.gz -L https://dl.google.com/dl/android/studio/ide-zips/3.5.2.0/android-studio-ide-191.5977832-linux.tar.gz
tar -zxf /tmp/android-studio.tar.gz
mv /tmp/android-studio $installdir

cat << 'ANDROID_STUDIO_DESKTOP' > /tmp/android-studio.desktop
[Desktop Entry]
Name=Android Studio
Type=Application
Exec=studio.sh
ANDROID_STUDIO_DESKTOP

desktop-file-install --dir=$HOME/.local/share/applications /tmp/android-studio.desktop
update-desktop-database $HOME/.local/share/applications
