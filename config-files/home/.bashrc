# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(zoxide init bash)"

if [ -f ~/.aliases ]; then
  source ~/.aliases
fi

eval "$(starship init bash)"

# Enable FZF
if [[ -x "$(command -v fzf)" ]]; then
    # Enable FZF Bash integration
    source /usr/share/fzf/shell/key-bindings.bash

    # Set FZF color scheme
    export FZF_DEFAULT_OPTS='--color fg:#c0caf5,bg:#1a1b26,hl:#bb9af7,bg+:#1a1b26,fg+:#c0caf5,hl+:#7dcfff,info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff,marker:#9ece6a,spinner:#9ece6a,header:#9ece6a'
fi

export DVM_DIR="/home/yeri/.dvm"
export PATH="$DVM_DIR/bin:$PATH"

export FLUTTER_DIR="$HOME/.local/opt/flutter"
export PATH="$FLUTTER_DIR/bin:$PATH"

export ANDROID_STUDIO_DIR="$HOME/.local/opt/android-studio"
export PATH="$ANDROID_STUDIO_DIR/bin:$PATH"
