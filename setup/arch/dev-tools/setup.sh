#!/bin/sh

echo "======================================"
echo "Installing dev tools..."
echo "======================================"

currentscript=$(realpath $0)
currentdir=$(dirname $currentscript)

$currentdir/database.sh
$currentdir/haskell.sh
$currentdir/nodejs.sh
$currentdir/php.sh
$currentdir/python.sh
$currentdir/ruby-rvm.sh
$currentdir/redis.sh
$currentdir/go.sh
$currentdir/rust.sh
$currentdir/docker.sh
# $currentdir/ocaml.sh
# $currentdir/android.sh
