#!/bin/sh

# packages for software development

echo "======================================"
echo "Installing devtools packages..."
echo "======================================"

sudo -S pacman --noconfirm -Syu postgresql php php-gd php-pgsql php-sqlite composer mariadb sqlite nodejs npm ruby python python-pynvim python2 nginx dbeaver
