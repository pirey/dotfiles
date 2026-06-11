#!/bin/bash

set -e

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Parse arguments
CREATE_SYMLINK=false
VERSION=""
for arg in "$@"; do
    case "$arg" in
        --symlink)
            CREATE_SYMLINK=true
            ;;
        *)
            VERSION="$arg"
            ;;
    esac
done

if [ -z "$VERSION" ]; then
    echo "Usage: $0 [--symlink] <version>"
    echo ""
    echo "Examples:"
    echo "  $0 v0.12.3"
    echo "  $0 --symlink v0.12.3"
    exit 1
fi
# Strip "v" prefix for directory naming
VERSION_NO_V="${VERSION#v}"

# Configuration
NVIM_DIR="$HOME/.local/opt/nvim-$VERSION_NO_V"
URL="https://github.com/neovim/neovim/releases/download/$VERSION/nvim-macos-arm64.tar.gz"

# Build arguments for download-binary.sh
ARGS=("$URL" "$NVIM_DIR")

if [ "$CREATE_SYMLINK" = true ]; then
    ARGS+=("bin/nvim")
fi

# Run download-binary.sh
exec "$SCRIPT_DIR/download-binary.sh" "${ARGS[@]}"
