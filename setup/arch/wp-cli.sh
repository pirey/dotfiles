#!/bin/sh

######################################
# wordpress cli
######################################

currentscript=$(realpath $0)
archdir=$(dirname $currentscript)
setupdir=$(dirname $archdir)

installdir=$HOME/.local/opt/wordpress

mkdir -p $installdir

curl -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /tmp/wp-cli.phar
chmod +x /tmp/wp-cli.phar
mv /tmp/wp-cli.phar $installdir/wp

