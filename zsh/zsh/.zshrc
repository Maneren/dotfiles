#!/bin/zsh

# important global vars from .zshenv:
# $ZSH - OMZ installation folder
# $_dotzsh_folder - location of common dotfiles

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

zinit snippet OMZP::sudo

zinit light-mode depth"1" for \
djui/alias-tips \
zsh-users/zsh-autosuggestions \
zsh-users/zsh-completions \
zdharma-continuum/fast-syntax-highlighting \
make Maneren/zsh-interactive-cd

autoload -Uz compinit
compinit -i -d "$ZSH_COMPDUMP"
zinit cdreplay -q

# custom prompt and aliases
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/prompt.zsh
