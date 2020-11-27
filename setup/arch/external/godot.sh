#!/bin/sh

# NOTE untested

######################################
# godot
######################################

install_destination=~/.local/bin/godot
desktopdir=~/.local/share/applications

mkdir -p $desktopdir
mkdir -p $install_destination

downloadurl="https://downloads.tuxfamily.org/godotengine/3.2.3/Godot_v3.2.3-stable_x11.64.zip"
filename="Godot_v3.2.3-stable_x11.64"

if [ ! -f /tmp/godot.zip ]; then
    curl -o /tmp/godot.zip -L $downloadurl
fi

cd /tmp
unzip /tmp/godot.zip
rm -rf $install_destination
mv "/tmp/$filename/$filename" $install_destination
cd -


# launcher

if [ -f /tmp/godot.desktop ]; then
    rm /tmp/godot.desktop
fi

echo "[Desktop Entry]" >> /tmp/godot.desktop
echo "Version=1.0" >> /tmp/godot.desktop
echo "Type=Application" >> /tmp/godot.desktop
echo "Name=Godot Engine" >> /tmp/godot.desktop
echo "Icon=${HOME}/dotfiles/icons/godot.png" >> /tmp/godot.desktop
echo "Exec=godot" >> /tmp/godot.desktop
echo "Comment=Multi-platform 2D and 3D game engine with a feature-rich editor" >> /tmp/godot.desktop
echo "Categories=Development;IDE;" >> /tmp/godot.desktop
echo "MimeType=application/x-godot-project;" >> /tmp/godot.desktop
echo "PrefersNonDefaultGPU=true;" >> /tmp/godot.desktop
echo "Terminal=false" >> /tmp/godot.desktop

desktop-file-install --dir=$HOME/.local/share/applications /tmp/godot.desktop
update-desktop-database $HOME/.local/share/applications
