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
    local VSROOT_BASE=$(basename "$VSROOT")
    export powerline_path_aliases="$VSROOT=$VSROOT_BASE"
  fi
  
  local BASE_COMMAND="powerline-go -shell zsh"
  local COMMAND_TOP="\
  $BASE_COMMAND\
  -error $?\
  -max-width 80\
  -modules venv,user,wsl,ssh,cwd,git,exit\
  -hostname-only-if-ssh\
  -path-aliases '$powerline_path_aliases'"

  local COMMAND_BOTTOM="\
  $BASE_COMMAND\
  -duration $__DURATION\
  -eval\
  -modules perms,root\
  -modules-right duration,time"
  
  local TOP=$(eval $COMMAND_TOP)
  eval $(eval $COMMAND_BOTTOM) # sets PROMPT and RPROMPT
  
  PROMPT=$TOP$'\n'$PROMPT
}

install_powerline_precmd() {
  # if powerline is already installed, return
  for f (${precmd_functions[@]}) [ "$f" = "powerline_precmd" ] && return
  precmd_functions+=(powerline_precmd)
}

[ "$TERM" != linux ] && install_powerline_precmd