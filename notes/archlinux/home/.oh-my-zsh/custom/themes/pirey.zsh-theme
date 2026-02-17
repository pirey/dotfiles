# zsh theme based on "tjkirch" with some modification

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}⚡"
ZSH_THEME_GIT_PROMPT_CLEAN=""


function is_in_tmux {
  if [[ -n $TMUX ]]; then

    echo "%{$fg[white]%}■%{$reset_color%}"
  fi
}


function prompt_char {
  if [ $UID -eq 0 ]; then echo "%{$fg[red]%}#%{$reset_color%}"; else echo ❯; fi
}

PROMPT='%{$fg_bold[blue]%}%~%{$reset_color%}$(git_prompt_info) $(is_in_tmux)
$(prompt_char) '

RPROMPT='%(?, ,%{$fg[red]%}FAIL: $?%{$reset_color%}) %{$fg[green]%}[%*]%{$reset_color%}'
