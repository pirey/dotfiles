#!/bin/sh

curl -L -o /tmp/elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz

gunzip /tmp/elm.gz

chmod +x /tmp/elm

sudo mv /tmp/elm /usr/local/bin/
