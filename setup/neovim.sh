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

	echo "OK neovim successfully installed..."
	echo "make sure you add ~/.local/opt/neovim/0.4.2/bin to your \$PATH"

    # installing vim-plug plugin manager for vim
    echo "checking vim-plug..."
    # make sure there is .vim-plug directory
    vimplugdir=$HOME/.vim-plug
    mkdir -p $vimplugdir
    if [ ! -e "$vimplugdir/autoload/plug.vim" ]; then
        echo "-> installing vim-plug..."
        curl -fLo $vimplugdir/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
    echo "OK vim-plug installed"

    echo "-> installing neovim plugins..."
    nvim "+PlugInstall | qa!"
    echo "OK neovim plugins installed"
else
	echo "directory ~/.local/opt/neovim already exists..."
fi
