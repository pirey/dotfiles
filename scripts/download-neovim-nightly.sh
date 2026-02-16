#!/bin/bash

set -e

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Parse arguments
CREATE_SYMLINK=false
if [ "$1" = "--symlink" ]; then
    CREATE_SYMLINK=true
fi

# Configuration
NVIM_NIGHTLY_DIR="$HOME/.local/opt/nvim-nightly"
URL="https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz"

# Build arguments for download-binary.sh
ARGS=("$URL" "$NVIM_NIGHTLY_DIR")

if [ "$CREATE_SYMLINK" = true ]; then
    ARGS+=("bin/nvim")
fi

# Run download-binary.sh
exec "$SCRIPT_DIR/download-binary.sh" "${ARGS[@]}"
