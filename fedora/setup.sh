#!/usr/bin/env bash

run_setup() {
	local command_name="$1"
	local script="$2"

  echo "======================================================"
  echo "Setting up '$command_name' ..."

	if [[ -x "$(command -v "$command_name")" ]]; then
		echo "Command '$command_name' is already executable."
	else
		echo "Command '$command_name' is not executable or does not exist. Running script '$script'..."
		# Run your script here
		source "$script"
	fi

  echo "======================================================"
}

# core packages
sudo dnf install -y \
  neovim \
  kitty \
  ripgrep \
  wl-clipboard \
  fd-find

# copr & etc
run_setup "keyd" "./keyd/setup.sh"

# flatpak
flatpak install flathub com.getpostman.Postman
