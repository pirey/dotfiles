# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#
source ~/.aliases
export PATH=$HOME/.config/composer/vendor/bin:$PATH

export PATH=$HOME/tools/bin:$PATH
export PATH=$HOME/tools/adminer/bin:$PATH
export PATH=$HOME/tools/circleci-cli_0.1.5389_linux_amd64:$PATH

export JAVA_HOME=$HOME/tools/jdk1.8.0_161
export PATH=$JAVA_HOME/bin:$PATH
export PATH=$JAVA_HOME/jre/bin:$PATH

# android standalone sdk
# export ANDROID_HOME=$HOME/tools/android
# export PATH=$ANDROID_HOME/tools:$PATH
# export PATH=$ANDROID_HOME/tools/bin:$PATH
# export PATH=$ANDROID_HOME/platform-tools:$PATH
# export PATH=$ANDROID_HOME/platform-tools/bin:$PATH


# android sdk with studio
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/tools/bin:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/platform-tools/bin:$PATH

# rust
export PATH=$HOME/.cargo/bin:$PATH

# z
. $HOME/tools/z/z.sh

# watchman
# echo 256 | sudo tee -a /proc/sys/fs/inotify/max_user_instances
# echo 32768 | sudo tee -a /proc/sys/fs/inotify/max_queued_events
# echo 65536 | sudo tee -a /proc/sys/fs/inotify/max_user_watches
# watchman shutdown-server

export GOROOT=$HOME/tools/go
export GOPATH=$HOME/go
export PATH=$HOME/go/bin:$PATH
export PATH=$GOROOT/bin:$PATH

# psc-package
export PATH=$HOME/tools/psc-package:$PATH

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# lua
alias lua=lua5.3
alias luac=luac5.3

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# deno
export PATH=/home/pirey/.deno/bin:$PATH

# screenkey
export PATH=/home/pirey/tools/screenkey:$PATH

# Node.js
export PATH=$HOME/tools/node-v10.15.0-linux-x64/bin:$PATH
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="./node_modules/.bin:$PATH" # local npm binaries
export PATH=$HOME/.npm-packages/bin:$PATH

# haskell
export PATH=$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH

# qutebrowser
export PATH=$HOME/tools/qutebrowser/bin:$PATH

# gitignore generator
function gi() { curl -sLw "\n" https://www.gitignore.io/api/\$@ ;}
