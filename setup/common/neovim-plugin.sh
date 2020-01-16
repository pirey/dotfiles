#!/bin/sh

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
