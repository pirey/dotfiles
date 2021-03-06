#!/bin/sh

# PHP

echo "======================================"
echo "Installing Python..."
echo "======================================"

sudo -S pacman --noconfirm -Syu python


echo "======================================"
echo "Installing pip packages..."
echo "======================================"

pip install --user autopep8 pynvim pipenv virtualenv
