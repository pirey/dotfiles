#!/bin/bash

set -e  # Exit on error

# Parse arguments
CREATE_SYMLINK=false
if [ "$1" = "--symlink" ]; then
    CREATE_SYMLINK=true
fi

# Define paths
NVIM_NIGHTLY_DIR="$HOME/.local/opt/nvim-nightly"
BIN_DIR="$HOME/.local/bin"

# Download URL
URL="https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz"

# Create directories if not exist
mkdir -p "$NVIM_NIGHTLY_DIR"
mkdir -p "$BIN_DIR"

# Download and extract
curl -L "$URL" | tar -xzf - -C "$NVIM_NIGHTLY_DIR" --strip-components=1

# Symlink (if requested)
if [ "$CREATE_SYMLINK" = true ]; then
    ln -sf "$NVIM_NIGHTLY_DIR/bin/nvim" "$BIN_DIR/nvim"
    echo "Neovim nightly installed to $NVIM_NIGHTLY_DIR and symlinked to $BIN_DIR/nvim"
else
    echo "Neovim nightly installed to $NVIM_NIGHTLY_DIR"
fi