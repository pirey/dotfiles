#!/bin/sh

if [ ! -f ~/.local/opt/neovim/0.4.2/bin/nvim ] ; then
    echo "installing neovim..."

	mkdir -p ~/.local/opt/neovim

    curl -o nvim.appimage -L https://github.com/neovim/neovim/releases/download/v0.4.2/nvim.appimage
    sudo chmod u+x ./nvim.appimage
    ./nvim.appimage --appimage-extract
    mv ./squashfs-root/usr ~/.local/opt/neovim/0.4.2
    rm nvim.appimage
    rm -rf ./squashfs-root

	echo "neovim successfully installed..."
	echo "make sure you add ~/.local/opt/neovim/0.4.2/bin to your \$PATH"
else
	echo "directory ~/.local/opt/neovim already exists..."
fi
