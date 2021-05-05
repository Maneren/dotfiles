#!/bin/zsh

source ~/.zshenv # also sets ZSH, DESKTOP and _dotzsh_(sub)folder variables

if [[ "$IS_DESKTOP" = "1" ]]; then
    tmpreaper 14d /tmp/
fi

source "$_dotzsh_subfolder/.zshenv"

# lazy load nvm
source $_dotzsh_folder/.nvm_lazyload

plugins=(sudo zsh-syntax-highlighting)
if [[ "$IS_DESKTOP" = "1" ]]; then
    plugins+=(colored-man-pages extract zsh-interactive-cd)
else
    plugins+=()
fi

source $ZSH/oh-my-zsh.sh

source "$_dotzsh_folder/.zshaliases"
source "$_dotzsh_subfolder/.zshaliases"

source "$_dotzsh_subfolder/.zshprompt"

