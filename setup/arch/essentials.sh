#!/bin/sh

# essentials packages for arch linux

sudo -S pacman --noconfirm -Syu openssh zsh neovim tmux fzf ripgrep feh network-manager-applet volumeicon picom scrot thunar xclip imagemagick p7zip zip unzip xdg-user-dirs xf86-video-intel xf86-video-nouveau xf86-input-libinput xorg xorg-xinit xorg-xinput xorg-xbacklight xautolock i3 rofi alacritty kitty pulseaudio pavucontrol udisks2 udiskie usbutils android-file-transfer android-udev

# if you want to use Gnome or other DE, add it accordingly
