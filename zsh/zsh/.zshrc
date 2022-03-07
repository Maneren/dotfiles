#!/bin/zsh

# important global vars from .zshenv:
# $ZSH - OMZ installation folder
# $_dotzsh_folder - location of common dotfiles

plugins=(
  sudo
  
  alias-tips
  zsh-autosuggestions
  zsh-completions
  zsh-interactive-cd
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/prompt.zsh
