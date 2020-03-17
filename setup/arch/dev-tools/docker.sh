#!/bin/sh

# packages for software development

echo "======================================"
echo "Installing docker..."
echo "======================================"

sudo pacman -S --noconfirm -Syu docker docker-compose
