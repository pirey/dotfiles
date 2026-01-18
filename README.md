# Dotfiles

This is my personal computer configuration files.

Checkout my [neovim](https://github.com/pirey/nvim) configuration.

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
- `cd config-files`
- `stow --adopt -t ~ home`

It may overwrite dotfiles because of the `--adopt` flag, review and adjust changes as necessary.

Also, it will only create symlinks for config under user home directory, so we need to create symlinks for other config files manually, e.g. keyd to /etc/keyd.
