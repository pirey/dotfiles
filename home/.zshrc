# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

if [ -f ~/.aliases ]; then
  source ~/.aliases
fi

if [ -f ~/.functions ]; then
  source ~/.functions
fi

# alt key
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

export PATH=$PATH:~/.local/share/nvim/mason/bin
export PATH=$PATH:~/.local/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:/opt/homebrew/bin

eval "$(zoxide init zsh)"

source <(fzf --zsh)

eval "$(starship init zsh)"

# bun completions
[ -s "/Users/yeri/.bun/_bun" ] && source "/Users/yeri/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/Users/yeri/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/Users/yeri/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

[ -f "/Users/yeri/.ghcup/env" ] && . "/Users/yeri/.ghcup/env" # ghcup-env

eval "$(direnv hook zsh)"

# export ESCDELAY=0
export FZF_DEFAULT_OPTS='--reverse --gutter=" " --cycle --color=16,fg:8,fg+:7,bg:-1,bg+:-1,gutter:-1,pointer:7,info:-1,border:8,prompt:-1,header:-1'
export FZF_DEFAULT_COMMAND='fd --type file --strip-cwd-prefix --follow --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

. "$HOME/.cargo/env"

# tmux
if [ -z "$TMUX" ]; then
    export PARENT_TERM_PROGRAM="$TERM_PROGRAM"
fi

