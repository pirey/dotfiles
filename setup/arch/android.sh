#!/bin/sh

######################################
# android related
######################################

currentscript=$(realpath $0)
archdir=$(dirname $currentscript)
setupdir=$(dirname $archdir)

$archdir/android-file-transfer.sh
$archdir/android-studio.sh
