#!/bin/sh

echo "installing z..."

if [ ! -d ~/z ]; then
    git clone git@github.com:rupa/z.git ~/z
fi

