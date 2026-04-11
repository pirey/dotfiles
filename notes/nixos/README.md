# My personal computer configuration

## Project structure
```
.
├── flake.lock
├── flake.nix
├── home-manager (user config files)
├── nixos (system config files)
└── scripts (helper scripts)
```

## Overview

I use [this starter](https://github.com/Misterio77/nix-starter-configs) to help me generate the initial nix flake setup.

### Usage
```
# apply user configuration
home-manager switch --flake .#pirey@thinkpad

# if home-manager is not installed yet, use nix shell then run home-manager
# nix shell nixpkgs#home-manager
# home-manager switch --flake .#pirey@thinkpad

```

```
# apply system configuration
sudo nixos-rebuild switch --flake .#thinkpad
```
