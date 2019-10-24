#!/bin/sh

# ubuntu 18.04

echo "installing common apt packages..."

sudo -S apt -y -m install ripgrep
sudo -S apt -y -m install git zsh neovim tmux curl postgresql pgmodeler
