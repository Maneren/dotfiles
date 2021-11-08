#!/bin/zsh

# uses https://github.com/justjanne/powerline-go

export PROMPT_DEBUG=0

zmodload zsh/datetime

preexec() {
    __TIMER=$EPOCHREALTIME
}

powerline_precmd() {
    local __DURATION=0
    
    [ -n $__TIMER ] && __DURATION="$(($EPOCHREALTIME - ${__TIMER:-$EPOCHREALTIME}))"
    unset __TIMER

    if [ "$PROMPT_DEBUG" = 1 ]; then
        echo "path aliases prev: $powerline_path_aliases"
    fi
    
    if [ -z "$powerline_path_aliases" ]; then
        export powerline_path_aliases="/mnt/c/Users/$WIN_USERNAME=Windows ~,/mnt/c/=C:,/mnt/d/=D:,/mnt/v/=VMs"
    fi

    if [ "$PROMPT_DEBUG" = 1 ]; then
        echo "term program: $TERM_PROGRAM"
        echo "vsroot, vsroot_base - prev: $VSROOT, $VSROOT_BASE"
    fi

    if [ "$TERM_PROGRAM" = "vscode" ] && [ -z "$VSROOT" ]; then
        export VSROOT="${PWD/$HOME/"~"}"
        local VSROOT_BASE=$(basename "$VSROOT")
        export powerline_path_aliases="$VSROOT=$VSROOT_BASE,$powerline_path_aliases"
        
        if [ "$PROMPT_DEBUG" = 1 ]; then
            echo "vsroot, vsroot_base: $VSROOT, $VSROOT_BASE"
        fi
    fi

    if [ "$PROMPT_DEBUG" = 1 ]; then
        echo "path aliases after: $powerline_path_aliases"
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
    
    if [ "$PROMPT_DEBUG" = 1 ]; then
        echo top: $(echo "$COMMAND_TOP" | xargs)
        echo bottom: $(echo "$COMMAND_BOTTOM" | xargs)
        echo "$PROMPT" > /tmp/zsh_prompt_test
    fi
}

install_powerline_precmd() {
    # if powerline is already installed, return
    for f (${precmd_functions[@]}) [ "$f" = "powerline_precmd" ] && return
    precmd_functions+=(powerline_precmd)
}

[ "$TERM" != linux ] && install_powerline_precmd