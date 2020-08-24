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
remove_file ~/.aliases
remove_file ~/.functions
remove_file ~/.paths
remove_file ~/.env
remove_file ~/.ctags
remove_file ~/.gitconfig
remove_file ~/.gitignore_global
remove_file ~/.tmux.conf
remove_file ~/.npmrc
remove_file ~/.prettierrc
remove_file ~/.xinitrc
remove_file ~/.ncmpcpp
remove_file ~/.spacemacs
remove_file ~/.railsrc
remove_file ~/.opam-helper

# remove_file ~/.bashrc
remove_file ~/.zshrc
remove_file ~/.oh-my-zsh/custom/themes/pirey.zsh-theme
remove_file ~/.zprofile
remove_file ~/.editorconfig
remove_file ~/.config/Dharkael
remove_file ~/.config/nvim
remove_file ~/.config/alacritty
remove_file ~/.config/kitty
remove_file ~/.config/polybar
remove_file ~/.config/mpd
remove_file ~/.config/i3
remove_file ~/.config/i3status
remove_file ~/.config/rofi
remove_file ~/.config/picom

echo "OK files removed"
