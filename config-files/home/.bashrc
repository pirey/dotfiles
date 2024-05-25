# .bashrc

export EDITOR="nvim"

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
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
  # tokyonight
  # export FZF_DEFAULT_OPTS='--color fg:#c0caf5,bg:#1a1b26,hl:#bb9af7,bg+:#1a1b26,fg+:#c0caf5,hl+:#7dcfff,info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff,marker:#9ece6a,spinner:#9ece6a,header:#9ece6a'
  # iceberg
  export FZF_DEFAULT_OPTS='--color fg:#c6c8d1,bg:#161821,hl:#bb9af7,bg+:#161821,fg+:#c6c8d1,hl+:#7dcfff,info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff,marker:#9ece6a,spinner:#9ece6a,header:#9ece6a'
fi

export DVM_DIR="/home/yeri/.dvm"
export PATH="$DVM_DIR/bin:$PATH"

export FLUTTER_DIR="$HOME/.local/opt/flutter"
export PATH="$FLUTTER_DIR/bin:$PATH"

export ANDROID_STUDIO_DIR="$HOME/.local/opt/android-studio"
export PATH="$ANDROID_STUDIO_DIR/bin:$PATH"

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

export PATH="$PATH":"$HOME/.pub-cache/bin"

test -r "$HOME/.opam/opam-init/init.sh" && . "$HOME/.opam/opam-init/init.sh" >/dev/null 2>/dev/null || true
function gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@; }

[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

export PATH="$HOME/.phpenv/bin:$PATH"
eval "$(phpenv init -)"

export PATH="~/.local/opt/nvim/bin:$PATH"
export PATH="~/.config/emacs/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

export PATH=$PATH:/usr/local/go/bin
