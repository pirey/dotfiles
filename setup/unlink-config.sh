#!/bin/sh

remove_file () {
    if [ ! -e "$1" ]; then
        echo "File $1 doesn't exists"
    else
        rm -rf "$1"
    fi
}

echo "-> removing files..."

# TODO get file names dynamically
remove_file ~/.toprc
remove_file ~/.agignore
remove_file ~/.aliases
remove_file ~/.ctags
remove_file ~/.gitconfig
remove_file ~/.gitignore_global
remove_file ~/.tmux.conf
remove_file ~/.npmrc
remove_file ~/.prettierrc
remove_file ~/.xinitrc

# remove_file ~/.bashrc
remove_file ~/.zshrc
remove_file ~/.zprofile
remove_file ~/.editorconfig
remove_file ~/.config/nvim
remove_file ~/.config/alacritty
remove_file ~/.config/polybar

echo "OK files removed"
