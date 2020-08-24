#!/bin/sh

echo "======================================"
echo "Installing essentials packages..."
echo "======================================"

sudo -S pacman --noconfirm -Syu openssh \
    zsh \
    neovim \
    tmux \
    fzf \
    bat \
    ripgrep \
    feh \
    network-manager-applet \
    picom \
    scrot \
    flameshot \
    xclip \
    imagemagick \
    p7zip \
    zip \
    unzip \
    xdg-user-dirs \
    xf86-video-intel \
    xf86-video-nouveau \
    xf86-input-libinput \
    xorg \
    xorg-xinit \
    xorg-xinput \
    xorg-xbacklight \
    xautolock \
    i3 \
    rofi \
    kitty \
    pulseaudio \
    pamixer \
    pavucontrol \
    udisks2 \
    udiskie \
    usbutils \
    android-file-transfer \
    android-udev \
    httpie \
    tree \
    cloc \
    git tk \
    mdp \
    gnome-system-monitor
