#!/bin/sh

######################################
# archlinux
######################################

currentscript=$(realpath $0)
archdir=$(dirname $currentscript)
setupdir=$(dirname $archdir)

$setupdir/link-config.sh
$setupdir/link-i3-config.sh

# refresh PATH
source ~/.paths

$archdir/essentials.sh
$archdir/dev-tools.sh
$archdir/extra.sh
$archdir/font.sh
$archdir/external.sh
$archdir/aur.sh
