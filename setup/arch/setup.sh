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
$archdir/extra.sh
$archdir/font.sh
$archdir/dev-tools/setup.sh
$archdir/aur/setup.sh
$archdir/external/setup.sh
