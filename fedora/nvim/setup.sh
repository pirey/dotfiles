#!/usr/bin/env bash

mkdir -p ~/.local/opt/
cd ~/.local/opt
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
tar -zxvf nvim-linux64.tar.gz
echo "export PATH=$HOME/.local/opt/nvim-linux64/bin:$PATH" >>~/.bashrc
