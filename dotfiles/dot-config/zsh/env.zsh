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
ZINIT[COMPINIT_OPTS]="-C"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

export HYPHEN_INSENSITIVE="true"
export CASE_SENSITIVE="false"
export DISABLE_AUTO_TITLE="true"
export ENABLE_CORRECTION="true"
export HIST_STAMPS="dd.mm.yyyy"
export HISTCONTROL=ignoreboth
export LESSHISTFILE="-"
export HISTFILE="$XDG_CACHE_HOME/.zsh-history"

export ANDROID_HOME="$XDG_DATA_HOME"/android/sdk
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export DOTNET_CLI_HOME="$XDG_DATA_HOME"/dotnet
export GHCUP_USE_XDG_DIRS=true
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export KDEHOME="$XDG_CONFIG_HOME"/kde
export NDK_HOME="$ANDROID_HOME/ndk/27.0.12077973"
export NODE_REPL_HISTORY="$XDG_CACHE_HOME/.node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages
export OMNISHARPHOME="$XDG_CONFIG_HOME"/omnisharp
export PLATFORMIO_CORE_DIR="$XDG_DATA_HOME"/platformio
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export PYTHONHISTFILE="$XDG_CACHE_HOME/.python_history"
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export STACK_XDG=1
export W3M_DIR="$XDG_DATA_HOME"/w3m
export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"
export WASMTIME_HOME="$XDG_DATA_HOME/wasmtime"
export WINEPREFIX="$XDG_DATA_HOME"/wine
export XCURSOR_PATH=/usr/share/icons:"$XDG_DATA_HOME/icons"

# use global target folder for cargo
export CARGO_TARGET_DIR="$XDG_CACHE_HOME"/cargo/target

export CC=clang
export CXX=clang++

export skip_global_compinit=1

export zic_case_insensitive=true
export zic_ignore_dot=true

path=(
    "$HOME/.local/bin"
    "$HOME/.cabal/bin"
    "$HOME/.ghcup/bin"
    "$HOME/.local/share/bob/nvim-bin"
    "$CARGO_HOME/bin"
    "$GOPATH/bin"
    "$PNPM_HOME"
    "$WASMTIME_HOME"
    "$HOME/.local/share/nvim/mason/bin"
    $path
)

# remove duplicates
typeset -gU path

export SELECTED_EDITOR="nvim"
export EDITOR="nvim"
export PAGER="moar"
export MOAR="--statusbar=bold --mousemode=scroll"
export MANPAGER='nvim +Man!'

# by default run make in parallel mode
export MAKEFLAGS="-j $(grep -c '^processor' /proc/cpuinfo)"

export TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E\nmemory\t%MMB\n================\n'

export DOTNET_CLI_TELEMETRY_OPTOUT=1
