#!/bin/sh

echo "======================================"
echo "Installing database engines..."
echo "======================================"

sudo -S pacman --noconfirm -Syu postgresql \
    mariadb \
    sqlite \
    nginx \
