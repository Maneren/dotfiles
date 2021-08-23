#!/bin/zsh

# uses custom modified version of powerline-go

export PROMPT_DEBUG=0

# load platform specific prompt function
source $_dotzsh_subfolder/prompt.zsh

# reset prompt (update the time) on enter key, before running the command
zmodload zsh/zle
reset-prompt-and-accept-line() {
    zle reset-prompt
    zle accept-line
}
zle -N reset-prompt-and-accept-line
bindkey '^m' reset-prompt-and-accept-line


install_powerline_precmd() {
    # if powerline is already installed, return
    for f (${precmd_functions[@]}) [ "$f" = "powerline_precmd" ] && return
    precmd_functions+=(powerline_precmd)
}

[ "$TERM" != linux ] && install_powerline_precmd