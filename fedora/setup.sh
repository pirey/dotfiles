#!/usr/bin/env bash

currentscript=$(realpath $0)
currentdir=$(dirname $currentscript)

run_setup() {
  local command_name="$1"
  local script="$2"

  echo "Setting up '$command_name' ..."

  if [[ -x "$(command -v "$command_name")" ]]; then
    echo "Command '$command_name' is already executable."
  else
    echo "Command '$command_name' is not executable or does not exist. Running script '$script'..."
    # Run setup script
    source "$script"
  fi

  echo "======================================================"
}

# core packages
sudo dnf install -y \
  kitty \
  ripgrep \
  wl-clipboard \
  fd-find \
  zoxide \
  fzf \
  gcc \
  gcc-c++ \
  make \
  ranger \
  obs-studio

run_setup "nvim" "./nvim/setup.sh"

# copr & etc
run_setup "keyd" "./keyd/setup.sh"
# run_setup "nvm" "./nvm/setup.sh"
run_setup "starship" "./starship/setup.sh"
# run_setup "emacs" "./emacs/setup.sh"

source $currentdir/font/setup.sh

# flatpak
# flatpak install flathub com.getpostman.Postman
