#!/bin/sh

if [ ! -d ~/.local/opt/nodejs/10.16.3 ] ; then
	mkdir -p ~/.local/opt

	curl -o nodejs.tar.xz -L https://nodejs.org/dist/v10.16.3/node-v10.16.3-linux-x64.tar.xz
	tar -xf nodejs.tar.xz
	mv node-v10.16.3-linux-x64 ~/.local/opt/nodejs/10.16.3
	rm nodejs.tar.xz

	echo "nodejs successfully installed..."
	echo "make sure you add ~/.local/opt/nodejs/10.16.3/bin to your \$PATH"
else
	echo "directory ~/.local/opt/nodejs/10.16.3 already exists..."
fi
