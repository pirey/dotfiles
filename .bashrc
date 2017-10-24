export PS1="\n\[\e[33m\]\u\[\e[m\]@\[\e[35m\]\h\[\e[m\]:\[\e[2m\]\w\[\e[m\]\n\\$ "

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files'
