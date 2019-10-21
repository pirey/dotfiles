#!/bin/sh

######################################
# tested on ubuntu 18.04 bionic beaver
######################################

setupdir=$(dirname "${0}")

"${setupdir}"/dotfiles.sh
"${setupdir}"/link-config.sh

"${setupdir}"/apt-packages.sh

# neovim
# the apt package 'neovim' above is only meant to install usefull dependencies
# in current ubuntu version (18.04), neovim is outdated, so we need to install from release
"${setupdir}"/neovim.sh

"${setupdir}"/python.sh
"${setupdir}"/php.sh
"${setupdir}"/composer.sh
"${setupdir}"/zsh.sh
"${setupdir}"/nodejs.sh
"${setupdir}"/base16.sh
"${setupdir}"/z.sh

######################################
# TODO
######################################
# configure keyboard delay speed
# swap capslock to escape

