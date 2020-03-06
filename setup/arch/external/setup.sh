#!/bin/sh

echo "======================================"
echo "Installing External packages..."
echo "======================================"

currentscript=$(realpath $0)
currentdir=$(dirname $currentscript)

$currentdir/adminer.sh
$currentdir/base16.sh
# $currentdir/code.sh
$currentdir/neovim-plugin.sh
$currentdir/postman.sh
$currentdir/tmux-plugin.sh
$currentdir/z.sh
$currentdir/zsh.sh
$currentdir/elm.sh
