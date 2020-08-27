#!/bin/sh

# ========================
# helper functions
# ========================

DOTFILES="$HOME/dotfiles"

link_file () {
    src=$1
    target=$2

    if [ ! -e "$1" ]; then
        echo "Skip linking $1: File doesn't exists"
        return
    fi

    echo "Linking $src to $target"

    remove_file $target

    ln -sf $src $target
}

link_home () {
    dotfiles_dir=${2:-$DOTFILES}

    src="${dotfiles_dir}/home/${1}"
    target="${HOME}/${1}"

    link_file $src $target
}

link_xdg_config () {
    dotfiles_dir=${2:-$DOTFILES}

    src="${dotfiles_dir}/home/.config/${1}"
    target="${HOME}/.config/${1}"

    link_file $src $target
}

remove_file () {
    if [ ! -e "$1" ]; then
        echo "Skip removing $1: File doesn't exists"
    else
        rm -rf "$1"
    fi
}

