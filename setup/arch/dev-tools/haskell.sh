#!/bin/sh

# packages for software development

echo "======================================"
echo "Installing devtools packages..."
echo "======================================"

sudo -S pacman --noconfirm -Syu ghc ghc-libs ghc-static cabal-install stack

# git clone https://aur.archlinux.org/haskell-ide-engine.git /tmp/hie
# cd /tmp/hie
# makepkg -si
# cd -
