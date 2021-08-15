#!/bin/zsh

# important global vars from .zshenv:
# $ZSH - OMZ installation folder
# $IS_DESKTOP
# $_dotzsh_folder - location of common dotfiles
# $_dotzsh_subfolder - location of platform specific dotfiles,
#      is either $_dotzsh_folder/desktop or $_dotzsh_folder/mobile

[ $IS_DESKTOP = 1 ] && tmpreaper 14d /tmp --runtime=10 --all --mtime-dir # WSL doesn't empty the tmp folder automatically

# lazy load nvm
source $_dotzsh_folder/.nvm_lazyload

# load rust env
source $HOME/.cargo/env

plugins=( sudo zsh-syntax-highlighting alias-tips )

[ $IS_DESKTOP = 1 ] && plugins+=( extract zsh-autocomplete zsh-interactive-cd )

source $ZSH/oh-my-zsh.sh

source $_dotzsh_folder/.zshaliases
source $_dotzsh_folder/.zshprompt
