#!/bin/sh

######################################
# tested on ubuntu 18.04 bionic beaver
######################################

currentscript=$(realpath $0)
ubuntudir=$(dirname $currentscript)
setupdir=$(dirname $ubuntudir)

$setupdir/link-i3-config.sh

$ubuntudir/setup.sh
$ubuntudir/i3-packages.sh
