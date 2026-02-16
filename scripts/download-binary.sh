#!/bin/sh

set -e

usage() {
    echo "Usage: $0 <url> <download_dir> [binary_path:alias ...]"
    echo ""
    echo "Arguments:"
    echo "  url           - URL to download (tar.gz archive)"
    echo "  download_dir  - Directory to extract the archive to"
    echo "  binary_path   - Relative path to binary in extracted archive (e.g., bin/nvim)"
    echo "  alias         - Optional: custom name for the symlink (e.g., nvim-nightly)"
    echo ""
    echo "Examples:"
    echo "  $0 https://example.com/app.tar.gz ~/.local/opt/myapp"
    echo "  $0 https://example.com/app.tar.gz ~/.local/opt/myapp bin/nvim"
    echo "  $0 https://example.com/app.tar.gz ~/.local/opt/myapp bin/nvim:nvim-nightly bin/node"
    exit 1
}

if [ $# -lt 2 ]; then
    usage
fi

URL="$1"
DOWNLOAD_DIR="$2"
shift 2

BIN_DIR="$HOME/.local/bin"
MAN_DIR="$HOME/.local/share/man"

# Create directories
mkdir -p "$DOWNLOAD_DIR"
mkdir -p "$BIN_DIR"

# Download and extract
echo "Downloading from $URL..."
curl -L "$URL" | tar -xzf - -C "$DOWNLOAD_DIR" --strip-components=1

# Link man pages if they exist
if [ -d "$DOWNLOAD_DIR/share/man" ]; then
    echo "Linking man pages..."
    mkdir -p "$MAN_DIR"
    for man_section in "$DOWNLOAD_DIR/share/man"/man*; do
        if [ -d "$man_section" ]; then
            section_name=$(basename "$man_section")
            mkdir -p "$MAN_DIR/$section_name"
            for man_page in "$man_section"/*; do
                if [ -f "$man_page" ]; then
                    ln -sf "$man_page" "$MAN_DIR/$section_name/"
                fi
            done
        fi
    done
fi

# Create symlinks
for binary_spec in "$@"; do
    # Parse binary:alias format using parameter expansion (POSIX compatible)
    case "$binary_spec" in
        *:*)
            binary_path="${binary_spec%%:*}"
            alias_name="${binary_spec#*:}"
            ;;
        *)
            binary_path="$binary_spec"
            alias_name=""
            ;;
    esac

    if [ -z "$alias_name" ]; then
        alias_name=$(basename "$binary_path")
    fi

    source_path="$DOWNLOAD_DIR/$binary_path"
    target_path="$BIN_DIR/$alias_name"

    if [ -f "$source_path" ]; then
        ln -sf "$source_path" "$target_path"
        echo "Linked $binary_path -> $target_path"
    else
        echo "Warning: Binary not found at $source_path"
    fi
done

echo "Downloaded to $DOWNLOAD_DIR"
