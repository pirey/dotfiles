#!/bin/sh

# PHP

echo "======================================"
echo "Installing PHP..."
echo "======================================"

sudo -S pacman --noconfirm -Syu php \
    php-gd \
    php-pgsql \
    php-sqlite \
    composer \


echo "======================================"
echo "Installing composer packages..."
echo "======================================"

composer global require laravel/installer emsifa/stuble:dev-master
