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
ln -sf $DOTFILES/home/.xinitrc $HOME/.xinitrc
ln -sf $DOTFILES/home/.ncmpcpp $HOME/.ncmpcpp

# sh
ln -sf $DOTFILES/home/.paths $HOME/.paths
ln -sf $DOTFILES/home/.aliases $HOME/.aliases
ln -sf $DOTFILES/home/.zshrc $HOME/.zshrc
ln -sf $DOTFILES/home/.zprofile $HOME/.zprofile

# .config
ln -sf $DOTFILES/home/.config/nvim $HOME/.config
ln -sf $DOTFILES/home/.config/alacritty $HOME/.config
ln -sf $DOTFILES/home/.config/polybar $HOME/.config
ln -sf $DOTFILES/home/.config/mpd $HOME/.config

echo "OK config files linked"
