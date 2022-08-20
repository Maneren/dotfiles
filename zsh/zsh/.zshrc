#!/bin/zsh

### Added by Zinit's installer
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
### End of Zinit's installer chunk

zinit ice as"completion" for \
    snippet OMZP::fd/_fd \
    snippet OMZP::adb/_adb

zinit snippet OMZP::command-not-found
zinit snippet OMZP::cp
zinit snippet OMZP::encode64
zinit snippet OMZP::fzf
zinit snippet OMZP::globalias
zinit snippet OMZP::rsync
zinit snippet OMZP::sudo

zinit snippet OMZL::history.zsh
zinit snippet OMZL::completion.zsh
zinit snippet OMZL::clipboard.zsh
zinit snippet OMZL::directories.zsh

zinit light-mode depth"1" for \
    djui/alias-tips \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions \
    zsh-users/zsh-history-substring-search \
    zdharma-continuum/fast-syntax-highlighting \
    make'download' Maneren/zsh-interactive-cd

autoload -Uz compinit
zicompinit
zinit cdreplay -q

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# custom aliases and prompt
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/prompt.zsh
source $ZDOTDIR/env.zsh
