#!/bin/sh

echo "installing z..."

if [ ! -d ~/.local/opt/z ]; then
    mkdir -p ~/.local/opt
    git clone git@github.com:rupa/z.git ~/.local/opt/z
fi

