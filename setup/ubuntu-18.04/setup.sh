#!/bin/sh

######################################
# tested on ubuntu 18.04 bionic beaver
######################################

currentscript=$(realpath $0)
ubuntudir=$(dirname $currentscript)
setupdir=$(dirname $ubuntudir)

$setupdir/dotfiles.sh
$setupdir/link-config.sh

source ~/.zshrc

$ubuntudir/common-packages.sh

$ubuntudir/python.sh
$ubuntudir/php.sh

# neovim
# the apt package 'neovim' inside common-packages.sh is only meant to install usefull dependencies for neovim
# in current ubuntu version (18.04), neovim is outdated, so we need to install from release
$setupdir/neovim.sh
$setupdir/composer.sh
$setupdir/zsh.sh
$setupdir/nodejs.sh
$setupdir/node-packages.sh
$setupdir/base16.sh
$setupdir/z.sh

######################################
# TODO
######################################
# configure keyboard delay speed
# swap capslock to escape

