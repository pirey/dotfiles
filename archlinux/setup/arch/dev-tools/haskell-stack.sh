#!/bin/sh

echo "======================================"
echo "Installing Haskell via stack..."
echo "======================================"

sudo -S pacman --noconfirm -Syu stack

stack install hlint hindent
