#!/bin/sh

######################################
# arch linux
######################################

currentscript=$(realpath $0)
archdir=$(dirname $currentscript)
setupdir=$(dirname $archdir)

$setupdir/link-config.sh
$setupdir/link-i3-config.sh

sudo -S pacman --noconfirm -Syu zsh neovim tmux fzf ripgrep postgresql php php-pgsql composer mariadb nodejs npm ruby feh network-manager-applet volumeicon compton scrot thunar python-pynvim xclip

$setupdir/zsh.sh

$setupdir/composer-packages.sh
$setupdir/adminer.sh
$setupdir/base16.sh
$setupdir/z.sh
$setupdir/npm-packages.sh
$setupdir/ruby-gems.sh
$setupdir/neovim-plugin.sh
