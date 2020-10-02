#!/bin/sh

echo "======================================"
echo "Installing Haskell via ghcup..."
echo "======================================"

curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
