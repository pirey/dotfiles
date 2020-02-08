#!/bin/sh

# packages for software development

echo "======================================"
echo "Installing devtools packages..."
echo "======================================"

sudo -S pacman --noconfirm -Syu stack

stack install hlint hindent
