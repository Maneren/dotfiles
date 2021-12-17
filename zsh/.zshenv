#!/bin/zsh

export _dotzsh_folder="$HOME/.dotfiles/zsh"

export IS_DESKTOP=1
[ $(uname -i) = aarch64 ] && IS_DESKTOP=0

if [ $IS_DESKTOP = 1 ]; then
    export _dotzsh_subfolder=$_dotzsh_folder/desktop
else
    export _dotzsh_subfolder=$_dotzsh_folder/mobile
fi

# Hyphen-insensitive completion
export HYPHEN_INSENSITIVE="true"
# Case-insensitive completion
export CASE_SENSITIVE="false"
# disable auto-setting terminal title.
export DISABLE_AUTO_TITLE="true"
export ENABLE_CORRECTION="true"
export HIST_STAMPS="dd.mm.yyyy"

# nvm
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
export NVM_DIR="$HOME/.nvm"

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
export DISABLE_AUTO_UPDATE=true
export ZSH_DISABLE_COMPFIX=true
export skip_global_compinit=1
export ZSH_COMPDUMP=~/.cache/.zcompdump
export DISABLE_LS_COLORS=false

export zic_case_insensitive=true
export zic_ignore_dot=true

export XDG_RUNTIME_DIR='/tmp/runtime-paul'

export GOPATH=$HOME/go
export VOLTA_HOME=$HOME/.volta
export PATH=$HOME/.local/bin:/opt/bin:$HOME/.cargo/bin:$VOLTA_HOME/bin:$PATH

export THMIP='10.9.179.135'

export SELECTED_EDITOR='/bin/nano'
export EDITOR='/bin/nano'
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

export HISTFILE=~/.cache/.zsh-history
export HISTSIZE=5000
export PYTHONHISTFILE=~/.cache/.python_history
export NODE_REPL_HISTORY=~/.cache/.node_repl_history
export npm_config_devdir=~/.cache/node-gyp
export LESSHISTFILE='-'

# load platform specific evn vars
source $_dotzsh_subfolder/env.zsh
