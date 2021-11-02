#!/bin/zsh

# important global vars from .zshenv:
# $ZSH - OMZ installation folder
# $IS_DESKTOP
# $_dotzsh_folder - location of common dotfiles
# $_dotzsh_subfolder - location of platform specific dotfiles,
#      is either $_dotzsh_folder/desktop or $_dotzsh_folder/mobile

# for zsh-autocomplete
zstyle ':autocomplete:tab:*' completion insert

plugins=(
  extract
  sudo

  alias-tips
  zsh-autocomplete
  zsh-autosuggestions
  zsh-completions
  zsh-interactive-cd
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

source $_dotzsh_folder/aliases.zsh
source $_dotzsh_folder/prompt.zsh
