#!/bin/sh

# PHP

echo "======================================"
echo "Installing PHP..."
echo "======================================"

# using single version
sudo -S pacman --noconfirm -Syu php \
    php-gd \
    php-pgsql \
    php-sqlite \
    composer

# using phpbrew
# git clone https://aur.archlinux.org/phpbrew.git /tmp/phpbrew
# cd /tmp/phpbrew
# makepkg -si --noconfirm
# cd -

echo "======================================"
echo "Installing composer packages..."
echo "======================================"

composer global require laravel/installer emsifa/stuble:dev-master
