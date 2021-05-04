#!/bin/zsh
export ZSH="/home/paul/.oh-my-zsh"

ZSH_THEME="robbyrussell"


source ~/.zshenv # also sets DESKTOP and _zshrc_subfolder variables

if [[ "$DESKTOP" = "1" ]]; then
    tmpreaper 14d /tmp/
fi

source $HOME/.zsh/$_zshrc_subfolder/.zshenv

# lazy load nvm
source ~/.zsh/.nvm_lazyload

plugins=(sudo zsh-syntax-highlighting)
if [[ "$DESKTOP" = "1" ]]; then
    plugins+=(colored-man-pages extract zsh-interactive-cd)
else
    plugins+=()
fi

source $ZSH/oh-my-zsh.sh

source $HOME/.zsh/.zshaliases
source $HOME/.zsh/$_zshrc_subfolder/.zshaliases
source $HOME/.zsh/$_zshrc_subfolder/.zshprompt
