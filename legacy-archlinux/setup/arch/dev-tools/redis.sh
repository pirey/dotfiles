#!/bin/sh

# packages for software development

echo "======================================"
echo "Installing redis..."
echo "======================================"

sudo -S pacman --noconfirm -Syu redis

# NOTE: further toolchain installation needed
# man rustup
