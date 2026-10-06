# Dotfiles

This is my personal computer configuration files.

## File Structure

```
.
├── etc/              # System-wide configs (e.g., keyd)
├── home/             # User configs (~)
│   ├── .config/
│   │   ├── nvim/     # Neovim configuration
│   │   └── ...
│   ├── .zshrc
│   ├── .gitconfig
│   └── ...
├── notes/            # OS-specific setup guides (fedora, macos, nixos, windows)
│   ├── fedora/
│   ├── macos/
│   ├── nixos/
│   ├── windows/
│   └── ...
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

- Kitty
- Alacritty

Preferred Fonts:

- IBM Plex Mono / Lilex
- Ioskeley Mono
- Hermit

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


## Migrating to Zed

### Common shortcuts (macOS)

- `Cmd-Shift-P` — command palette
- `Cmd-P` — find file
- `Cmd-Shift-F` — search in project
- `Cmd-Shift-O` — find symbol in file; `Cmd-T` — find symbol in project
- `Cmd-Shift-E` — project panel; `Cmd-Shift-B` — outline panel
- `Ctrl` + backtick — toggle terminal
- `Cmd-Shift-M` — diagnostics
- `Cmd-,` — settings

### Custom keymap

See [`home/.config/zed/keymap.json`](home/.config/zed/keymap.json). Current custom bindings:

- In normal Vim mode, `;` opens the command palette and `:` repeats the last find.
- In normal or visual Vim mode, `j`/`k` move by screen lines, `s` jumps to a word, `g a` switches to the alternate file, `g h`/`g l` move to line start/end, and `m m` jumps to the matching bracket.
- In normal mode, `g p` selects the last pasted text. In visual mode, `g l` extends to line end and `a m` selects through the matching bracket.
- `Ctrl-Tab` / `Ctrl-Shift-Tab` switch between open items in the editor and terminal.
- In the terminal, `Cmd-[` / `Cmd-]` move to the left/right pane.
- `Ctrl-Cmd-R` opens recent projects.
- In the editor, `Ctrl-M` inserts a newline.

### Missing feature in Zed:

- Compare changes against a base branch (e.g. for review)
- Search Git history by changed content (pickaxe, `git log -S`)

Workaround:

- Search commit messages with the `Git Graph: Open` action, then use its search box.
