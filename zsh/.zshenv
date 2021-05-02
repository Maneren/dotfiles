#!/bin/zsh

export skip_global_compinit=1
export ZSH_COMPDUMP=~/.cache/.zcompdump

# Hyphen-insensitive completion
export HYPHEN_INSENSITIVE="true"
# Case-insensitive completion
export CASE_SENSITIVE="false"
# disable auto-setting terminal title.
export DISABLE_AUTO_TITLE="true"
export ENABLE_CORRECTION="true"
export HIST_STAMPS="dd.mm.yyyy"
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true

if [ $(uname -i) = "x86_64" ]; then
  export DESKTOP=1
fi

export zic_case_insensitive=true

export XDG_RUNTIME_DIR='/tmp/runtime-paul'

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
export GOPATH=$HOME/go
export PATH=~/.local/bin:~/bin:/opt/bin:$PATH

export THMIP='10.9.179.135'

export SELECTED_EDITOR='/bin/nano'
export EDITOR='/bin/nano'
export LANG=en_US.UTF-8
export LANGUAGE=en
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

export HISTFILE=~/.cache/.zsh-histfile
export PYTHONHISTFILE=~/.cache/.python_history
export NODE_REPL_HISTORY=~/.cache/.node_repl_history
export npm_config_devdir=~/.cache/node-gyp
export LESSHISTFILE='-'
