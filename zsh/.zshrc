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

source $_dotzsh_folder/aliases.zsh
source $_dotzsh_folder/prompt.zsh
