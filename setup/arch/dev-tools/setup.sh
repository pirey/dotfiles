#!/bin/sh

echo "======================================"
echo "Installing dev tools..."
echo "======================================"

currentscript=$(realpath $0)
currentdir=$(dirname $currentscript)

$currentdir/database.sh
$currentdir/haskell.sh
$currentdir/nodejs.sh
# $currentdir/ocaml.sh
$currentdir/php.sh
$currentdir/python.sh
$currentdir/ruby-rvm.sh
# $currentdir/rust.sh
# $currentdir/android.sh
