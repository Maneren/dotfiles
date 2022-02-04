#!/bin/zsh

# uses https://github.com/justjanne/powerline-go

export PROMPT_DEBUG=0

zmodload zsh/datetime

preexec() {
  __TIMER=$EPOCHREALTIME
}

powerline_precmd() {
  [ "$PROMPT_DEBUG" = 1 ] && set -x
  
  local __DURATION=0
  
  [ -n $__TIMER ] && __DURATION="$(($EPOCHREALTIME - ${__TIMER:-$EPOCHREALTIME}))"
  unset __TIMER
  
  if [ "$TERM_PROGRAM" = "vscode" ] && [ -z "$VSROOT" ]; then
    export VSROOT="${PWD/$HOME/"~"}"
    export powerline_path_aliases="-path-aliases '$VSROOT=$(basename "$VSROOT")'"
  fi
  
  local BASE_COMMAND="powerline-go -shell zsh"
  
  local COMMAND_TOP="$BASE_COMMAND -error $? -max-width 80\
  -modules venv,user,wsl,ssh,cwd,git,exit\
  -hostname-only-if-ssh $powerline_path_aliases"
  
  local COMMAND_BOTTOM="$BASE_COMMAND -eval\
  -duration $__DURATION -modules perms,root\
  -modules-right duration,time"
  
  local TOP=$(${=COMMAND_TOP}) # "=" forces word splitting
  eval $(${=COMMAND_BOTTOM}) # sets PROMPT and RPROMPT
  
  PROMPT=$TOP$'\n'$PROMPT
}

install_powerline_precmd() {
  # if powerline is already installed, return
  for f (${precmd_functions[@]}) [ "$f" = "powerline_precmd" ] && return
  precmd_functions+=(powerline_precmd)
}

[ "$TERM" != linux ] && install_powerline_precmd