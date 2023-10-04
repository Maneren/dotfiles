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
ZINIT[ZCOMPDUMP_PATH]="$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

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
export BUN_INSTALL="$HOME/.bun"

# use global target folder for cargo
export CARGO_TARGET_DIR="$XDG_CACHE_HOME"/cargo/target

export skip_global_compinit=1

export zic_case_insensitive=true
export zic_ignore_dot=true

export PATH="$HOME/.local/bin:/opt/bin:$GOPATH/bin:$CARGO_HOME/bin:$PNPM_HOME:$BUN_INSTALL/bin:$PATH"

export SELECTED_EDITOR="/bin/nvim"
export EDITOR="/bin/nvim"

export TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E\nmemory\t%MKB\n================\n'

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
