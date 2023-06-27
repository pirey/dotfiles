#!/usr/bin/env bash

if ! fc-list | grep -i -q "JetBrainsMono"; then
  echo "Installing font..."
  wget -P /tmp https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
  unzip -d ~/.local/share/fonts/JetBrainsMono /tmp/JetBrainsMono.zip
  fc-cache
fi

echo "Font installed"

