#!/bin/zsh

ZDOTDIR="$HOME/.dotfiles/zsh"

declare -A ZINIT
ZINIT[ZCOMPDUMP_PATH]="$HOME/.cache/.zcompdump"

export HYPHEN_INSENSITIVE="true"
export CASE_SENSITIVE="false"
export DISABLE_AUTO_TITLE="true"
export ENABLE_CORRECTION="true"
export HIST_STAMPS="dd.mm.yyyy"
export HISTFILE="$HOME/.cache/.zsh-history"
export HISTCONTROL=ignoreboth
export PYTHONHISTFILE="$HOME/.cache/.python_history"
export NODE_REPL_HISTORY="$HOME/.cache/.node_repl_history"
export npm_config_devdir="$HOME/.cache/node-gyp"
export LESSHISTFILE="-"

export skip_global_compinit=1
export DISABLE_LS_COLORS=false

export zic_case_insensitive=true
export zic_ignore_dot=true

export GOPATH="$HOME/go"
export CARGO_BIN="$HOME/.cargo/bin"
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$HOME/.local/bin:/opt/bin:$GOPATH/bin:$CARGO_BIN:$PNPM_HOME:$PATH"

export SELECTED_EDITOR="/bin/nvim"
export EDITOR="/bin/nvim"
export DOTNET_CLI_TELEMETRY_OPTOUT=1

export LANG="en_US.UTF-8"
export LANGUAGE="en"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="cs_CZ.UTF-8"
export LC_COLLATE="cs_CZ.UTF-8"
export LC_MONETARY="cs_CZ.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_PAPER="cs_CZ.UTF-8"
export LC_NAME="cs_CZ.UTF-8"
export LC_ADDRESS="cs_CZ.UTF-8"
export LC_TELEPHONE="cs_CZ.UTF-8"
export LC_MEASUREMENT="cs_CZ.UTF-8"
export LC_IDENTIFICATION="cs_CZ.UTF-8"
