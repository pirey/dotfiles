#!/bin/sh

######################################
# archlinux
######################################

currentscript=$(realpath $0)
archdir=$(dirname $currentscript)
setupdir=$(dirname $archdir)

$setupdir/link-config.sh
$setupdir/link-i3-config.sh

$archdir/essentials.sh
$archdir/dev-tools.sh
$archdir/extra.sh
$archdir/font.sh

$setupdir/zsh.sh

$setupdir/composer-packages.sh
$setupdir/adminer.sh
$setupdir/base16.sh
$setupdir/z.sh
$setupdir/npm-packages.sh
$setupdir/ruby-gems.sh
$setupdir/neovim-plugin.sh
$setupdir/tmux-plugin.sh
