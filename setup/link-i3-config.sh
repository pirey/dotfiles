#!/bin/sh

# doftiles directory
DOTFILES="$HOME/dotfiles"
if [ "$1" != "" ]; then
    DOTFILES=$1
fi

$DOTFILES/setup/unlink-i3-config.sh

echo "symlinking config for i3wm..."
ln -sf $DOTFILES/home/.config/i3 $HOME/.config
ln -sf $DOTFILES/home/.config/i3status $HOME/.config
ln -sf $DOTFILES/home/.config/rofi $HOME/.config
ln -sf $DOTFILES/home/.config/picom $HOME/.config

echo "completed"
