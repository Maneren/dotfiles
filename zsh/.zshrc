#!/bin/zsh

# important global vars from .zshenv:
# $ZSH - OMZ installation folder
# $IS_DESKTOP 
# $_dotzsh_folder - location of common dotfiles
# $_dotzsh_subfolder - location of platform specific dotfiles,
#      is either $_dotzsh_folder/desktop or $_dotzsh_folder/mobile

if [[ "$IS_DESKTOP" = "1" ]]; then
    tmpreaper 14d /tmp/ # WSL doesn't empty the tmp folder automatically
fi

source $_dotzsh_subfolder/.zshenv

# lazy load nvm
source $_dotzsh_folder/.nvm_lazyload

plugins=(sudo zsh-syntax-highlighting)

if [[ "$IS_DESKTOP" = "1" ]]; then
    plugins+=(colored-man-pages extract zsh-interactive-cd)
else
    plugins+=()
fi

source $ZSH/oh-my-zsh.sh

source $_dotzsh_folder/.zshaliases
source $_dotzsh_subfolder/.zshaliases

source $_dotzsh_folder/.zshprompt
source $_dotzsh_subfolder/.zshprompt
