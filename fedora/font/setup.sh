#!/usr/bin/env bash

if ! fc-list | grep -i -q "JetBrainsMono"; then
  echo "Installing font..."
  # mkdir -p ~/.local/share/fonts/JetBrainsMono
  # mkdir -p ~/.local/share/fonts/IntelOneMono
  mkdir -p ~/.local/share/fonts/IBMPlexMono
  # wget -P /tmp https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
  # wget -P /tmp https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/IntelOneMono.zip
  wget -P /tmp https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/IBMPlexMono.zip
  # unzip -d ~/.local/share/fonts/JetBrainsMono /tmp/JetBrainsMono.zip
  # unzip -d ~/.local/share/fonts/IntelOneMono /tmp/IntelOneMono.zip
  unzip -d ~/.local/share/fonts/IBMPlexMono /tmp/IBMPlexMono.zip
  fc-cache
fi

echo "Font installed"
