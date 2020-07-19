#!/bin/sh

echo "======================================"
echo "Installing Node.js..."
echo "======================================"

sudo -S pacman --noconfirm -Syu nodejs npm

echo "======================================"
echo "Installing npm packages..."
echo "======================================"

npm i -g intelephense \
    neovim \
    http-server \
    yarn \
    pnpm \
    prettier \
    @prettier/plugin-php \
    eslint \
    ionic \
    @adonisjs/cli
