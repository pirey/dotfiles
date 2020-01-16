#!/bin/sh

# ubuntu 18.04

echo "installing i3 packages..."

sudo -S apt -y -m install i3-wm i3lock i3status feh scrot rofi nm-tray lxappearance volumeicon-alsa compton xserver-xorg-input-synaptics

curl -o light.deb -L https://github.com/haikarainen/light/releases/download/v1.2/light_1.2_amd64.deb

sudo dpkg -i light.deb
rm light.deb
