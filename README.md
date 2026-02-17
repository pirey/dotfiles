# Dotfiles

This is my personal computer configuration files.

Checkout my [neovim](https://github.com/pirey/nvim) configuration.

## File Structure

```
.
├── etc/              # System-wide configs (e.g., keyd)
├── home/             # User configs (~)
│   ├── .config/      # CLI tools (alacritty, ghostty, tmux, starship, etc.)
│   ├── .zshrc        # Shell config
│   ├── .gitconfig   # Git config
│   └── ...
├── notes/            # OS-specific setup guides (archlinux, fedora, macos, nixos, windows)
├── scripts/          # Utility scripts
└── README.md
```

## Overview

CLI:

- zsh/oh-my-zsh
- nvim
- tmux
- fzf
- ripgrep
- fd
- zoxide
- starship.rs

Terminal:

- Ghostty

Fonts:

- IBM Plex Mono
- Ioskeley Mono (Berkeley Mono clone)

Keyboard map:

- keyd (Linux)
- karabiner elements (MacOS)
- auto hot key (Windows)

## Configuration

The following command will create symlinks to the configuration files in the home directory.

- Install GNU [stow](https://www.gnu.org/software/stow/)
- `stow --adopt -t ~ home`

It may overwrite dotfiles because of the `--adopt` flag, review and adjust changes as necessary.

Also, it will only create symlinks for config under user home directory, so we need to create symlinks for other config files manually, e.g. keyd to /etc/keyd.
