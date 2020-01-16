#!/bin/sh

######################################
# package from external sources
######################################

currentscript=$(realpath $0)
archdir=$(dirname $currentscript)
setupdir=$(dirname $archdir)
aurdir=$archdir/aur

$aurdir/polybar.sh
$aurdir/screenkey.sh
