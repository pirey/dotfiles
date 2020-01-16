#!/bin/sh

######################################
# package from external sources
######################################

echo "======================================"
echo "Installing AUR packages..."
echo "======================================"

currentscript=$(realpath $0)
archdir=$(dirname $currentscript)
setupdir=$(dirname $archdir)
aurdir=$archdir/aur

$aurdir/polybar.sh
$aurdir/screenkey.sh
