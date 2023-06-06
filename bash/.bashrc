#!/bin/bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='grep -E --color=auto'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        # shellcheck disable=SC1091
        source /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        # shellcheck disable=SC1091
        source /etc/bash_completion
    fi
fi

export LANG=en_US.UTF-8
export LANGUAGE=en
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=cs_CZ.UTF-8
export LC_COLLATE=cs_CZ.UTF-8
export LC_MONETARY=cs_CZ.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_PAPER=cs_CZ.UTF-8
export LC_NAME=cs_CZ.UTF-8
export LC_ADDRESS=cs_CZ.UTF-8
export LC_TELEPHONE=cs_CZ.UTF-8
export LC_MEASUREMENT=cs_CZ.UTF-8
export LC_IDENTIFICATION=cs_CZ.UTF-8

export GOPATH=$HOME/go
export SELECTED_EDITOR="/bin/nano"

# shellcheck disable=SC1090
source ~/.dotfiles/bash/.bash_aliases
# shellcheck disable=SC1090
source ~/.dotfiles/bash/.bash_prompt

# shellcheck disable=SC1091
source "$HOME/.cargo/env"
