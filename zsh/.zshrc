#!/bin/zsh

source ~/.zshenv # also sets ZSH, DESKTOP and _zshrc_subfolder variables

if [[ "$IS_DESKTOP" = "1" ]]; then
    tmpreaper 14d /tmp/
fi

source "$HOME/.zsh/$_zshrc_subfolder/.zshenv"

# lazy load nvm
source ~/.zsh/.nvm_lazyload

plugins=(sudo zsh-syntax-highlighting)
if [[ "$IS_DESKTOP" = "1" ]]; then
    plugins+=(colored-man-pages extract zsh-interactive-cd)
else
    plugins+=()
fi

source $ZSH/oh-my-zsh.sh

source "$HOME/.zsh/.zshaliases"
source "$HOME/.zsh/$_zshrc_subfolder/.zshaliases"

source "$HOME/.zsh/$_zshrc_subfolder/.zshprompt"
