#!/bin/zsh

# env for interactive shells

_comp_options+=(globdots)   # include hidden files in completion
_comp_options+=(nocaseglob) # case insensitive globbing

setopt interactivecomments
setopt long_list_jobs
setopt extended_glob

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

declare -A ZINIT
ZINIT[ZCOMPDUMP_PATH]="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

export HYPHEN_INSENSITIVE="true"
export CASE_SENSITIVE="false"
export DISABLE_AUTO_TITLE="true"
export ENABLE_CORRECTION="true"
export HIST_STAMPS="dd.mm.yyyy"
export HISTCONTROL=ignoreboth
export LESSHISTFILE="-"
export HISTFILE="$XDG_CACHE_HOME/.zsh-history"

export ANDROID_HOME="$XDG_DATA_HOME"/android
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export KDEHOME="$XDG_CONFIG_HOME"/kde
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export PYTHONHISTFILE="$XDG_CACHE_HOME/.python_history"
export NODE_REPL_HISTORY="$XDG_CACHE_HOME/.node_repl_history"
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export WINEPREFIX="$XDG_DATA_HOME"/wine
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export PYENV_ROOT="$XDG_DATA_HOME/.pyenv"

# use global target folder for cargo
export CARGO_TARGET_DIR="$XDG_CACHE_HOME"/cargo/target

export skip_global_compinit=1

export zic_case_insensitive=true
export zic_ignore_dot=true

path+=(
    "$HOME/.local/bin"
    "$HOME/.ghcup/bin"
    "$PYENV_ROOT/bin"
    "$CARGO_HOME/bin"
    "$PNPM_HOME"
)

# remove duplicates
typeset -gU path

export SELECTED_EDITOR="nv"
export EDITOR="nv"

export TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E\nmemory\t%MKB\n================\n'

export DOTNET_CLI_TELEMETRY_OPTOUT=1
