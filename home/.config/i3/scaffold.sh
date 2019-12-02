#!/bin/sh -e

# run essential apps

if ! pidof -x kitty; then
    i3-msg 'workspace 1; exec kitty'
fi

if ! pidof -x firefox; then
    i3-msg 'workspace 2; exec firefox'
fi
