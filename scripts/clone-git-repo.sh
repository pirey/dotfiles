#!/usr/bin/env bash
set -euo pipefail

prefix="$HOME/code"
shallow=true

usage() {
    echo "Usage: $0 [OPTIONS] <git-repo-url>"
    echo "Options:"
    echo "  -p, --prefix <path>  Base directory for clones (default: \$HOME/code)"
    echo "  --no-shallow         Clone entire history (no --depth=1)"
    echo ""
    echo "Examples:"
    echo "  $0 git@github.com:ratatui/ratatui.git"
    echo "  $0 --prefix /workspace git@github.com:ratatui/ratatui.git"
    echo "  $0 --no-shallow git@github.com:ratatui/ratatui.git"
    exit 1
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -p|--prefix)
            if [[ -z "${2:-}" ]]; then
                echo "Error: $1 requires a path argument"
                exit 1
            fi
            prefix="$2"
            shift 2
            ;;
        --no-shallow)
            shallow=false
            shift
            ;;
        -h|--help)
            usage
            ;;
        -*)
            echo "Error: Unknown option: $1"
            usage
            ;;
        *)
            break
            ;;
    esac
done

if [[ $# -lt 1 ]]; then
    usage
fi

repo_url="$1"

if [[ "$repo_url" =~ ^git@([^:]+):(.+)\.git$ ]]; then
    host="${BASH_REMATCH[1]}"
    path="${BASH_REMATCH[2]}"
elif [[ "$repo_url" =~ ^https?://([^/]+)/(.+)\.git$ ]]; then
    host="${BASH_REMATCH[1]}"
    path="${BASH_REMATCH[2]}"
else
    echo "Error: Invalid git repo URL format"
    exit 1
fi

IFS='/' read -r owner repo_name <<< "$path"

target_dir="$prefix/$host/$owner/$repo_name"

mkdir -p "$(dirname "$target_dir")"

if [[ "$shallow" == "true" ]]; then
    git clone --depth=1 "$repo_url" "$target_dir"
else
    git clone "$repo_url" "$target_dir"
fi

echo "Cloned to: $target_dir"
