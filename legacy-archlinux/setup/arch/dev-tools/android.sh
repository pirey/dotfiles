#!/bin/sh

echo "======================================"
echo "Installing Android Tools..."
echo "======================================"

sudo -S pacman --noconfirm -Syu jdk-openjdk ant
