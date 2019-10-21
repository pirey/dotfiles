#!/bin/sh

# doftiles directory
DOTFILES="$HOME/dotfiles"
if [ "$1" != "" ]; then
    DOTFILES=$1
fi

$DOTFILES/setup/unlink-i3-config.sh

# link base config files
$DOTFILES/setup/link-config.sh

echo "symlinking config for i3wm..."
ln -sf $DOTFILES/home/.config/i3 $HOME/.config
ln -sf $DOTFILES/home/.config/i3status $HOME/.config
ln -sf $DOTFILES/home/.config/volumeicon $HOME/.config
ln -sf $DOTFILES/home/.config/rofi $HOME/.config

# custom scripts
mkdir -p $HOME/.local/bin
ln -sf $DOTFILES/home/.local/bin/fuzzy_lock.sh $HOME/.local/bin/fuzzy_lock.sh

echo "completed"
