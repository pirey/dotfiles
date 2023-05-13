# Pirey's personal computer configuration

## Project structure
```
.
├── legacy-archlinux (my old archlinux config files)
├── flake.lock
├── flake.nix
├── home-manager (user config files)
├── nixos (system config files)
└── scripts (helper scripts)
```

## I'm migrating to NixOS

The idea of being able to capture the system configuration and reproduce it whenever I need, fascinated me. This is what I have been yearning for in the old days of managing dotfiles for arch linux.

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
