#!/bin/sh

# packages for software development

echo "======================================"
echo "Installing ocaml / reasonml packages..."
echo "======================================"

sudo -S pacman --noconfirm -Syu ocaml opam

opam init
opam install merlin
opam user-setup install

# npm i -g ocaml-language-server bs-platform

curl -L https://github.com/jaredly/reason-language-server/releases/download/1.7.5/rls-linux.zip -o /tmp/reason-ls.zip
cd /tmp
unzip reason-ls.zip
mv /tmp/rls-linux/reason-language-server $HOME/.local/bin

cd -
