#!/bin/sh

# packages for software development

echo "======================================"
echo "Installing rust toolchain..."
echo "======================================"

sudo -S pacman --noconfirm -Syu rustup

# NOTE: further toolchain installation needed
# see help
