#!/bin/sh

######################################
# package from external sources
######################################

echo "======================================"
echo "Installing AUR packages..."
echo "======================================"

currentscript=$(realpath $0)
currentdir=$(dirname $currentscript)

$currentdir/polybar.sh
$currentdir/screenkey.sh
