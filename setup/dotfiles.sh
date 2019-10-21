#!/bin/sh

echo "installing dotfiles..."

if [ ! -d ~/dotfiles ]; then
    # TODO dynamic repo
    # make sure ssh key is already setup for github access
    git clone git@github.com:pirey/dotfiles.git ~/dotfiles
fi

