#!/bin/sh

echo "setup python..."

# mostly used for python support for neovim

sudo -S apt -y install python-pip python3-pip
pip2 install pynvim
pip3 install pynvim
