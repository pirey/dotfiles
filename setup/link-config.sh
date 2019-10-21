#!/bin/sh

# ========================
# DOTFILES

# doftiles directory
DOTFILES="$HOME/dotfiles"
if [ "$1" != "" ]; then
    DOTFILES=$1
fi

# unlink files first
$DOTFILES/setup/unlink-config.sh

# installing vim-plug plugin manager for vim
echo "-> checking vim-plug (plugin manager)"
# make sure there is .vim-plug directory
vimplugdir=$HOME/.vim-plug
mkdir -p $vimplugdir
if [ ! -e "$vimplugdir/autoload/plug.vim" ]; then
    echo "-> installing vim-plug..."
    curl -fLo $vimplugdir/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "OK vim-plug installed"
else
    echo "OK vim-plug already installed"
fi


# TODO get all files dynamically
echo "-> creating symlinks..."

# make sure there is .config folder
mkdir -p $HOME/.config

# tmux
ln -sf $DOTFILES/home/.tmux.conf $HOME/.tmux.conf

# global config
ln -sf $DOTFILES/home/.toprc $HOME/.toprc
ln -sf $DOTFILES/home/.agignore $HOME/.agignore
ln -sf $DOTFILES/home/.ctags $HOME/.ctags
ln -sf $DOTFILES/home/.gitconfig $HOME/.gitconfig
ln -sf $DOTFILES/home/.gitignore_global $HOME/.gitignore_global
ln -sf $DOTFILES/home/.editorconfig $HOME/.editorconfig
ln -sf $DOTFILES/home/.npmrc $HOME/.npmrc
ln -sf $DOTFILES/home/.prettierrc $HOME/.prettierrc

# sh
ln -sf $DOTFILES/home/.aliases $HOME/.aliases
ln -sf $DOTFILES/home/.zshrc $HOME/.zshrc

# .config
ln -sf $DOTFILES/home/.config/nvim $HOME/.config


echo "OK symlinks created"

echo "-> installing neovim plugins..."
nvim "+PlugInstall! | qa!"
echo "OK neovim plugins installed"

echo "OK All clear"
