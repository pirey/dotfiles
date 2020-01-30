#!/bin/sh

# packages for software development

echo "======================================"
echo "Installing devtools packages..."
echo "======================================"

sudo -S pacman --noconfirm -Syu ghc ghc-libs ghc-static cabal-install stack
