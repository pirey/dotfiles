#!/bin/sh

# installing tmux plugin manager
echo "checking tpm..."

# make sure there is tpm directory
tmuxplugindir=$HOME/.tmux/plugins/tpm
if [ ! -d $tmuxplugindir ]; then
    echo "-> installing tpm..."
    git clone https://github.com/tmux-plugins/tpm $tmuxplugindir
fi
echo "OK tpm installed"

echo "Reload tmux, then press prefix + I to install tmux plugins"


