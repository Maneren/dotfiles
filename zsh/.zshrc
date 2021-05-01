#!/bin/zsh
export ZSH="/home/paul/.oh-my-zsh"

ZSH_THEME="robbyrussell"


. ~/.zshenv

if [[ "$DESKTOP" = "1" ]]; then
    tmpreaper 14d /tmp/
fi

if [[ "$DESKTOP" = "1" ]]; then
    . ~/.zsh/.zshenv_desktop
else
    . ~/.zsh/.zshenv_mobile
fi

if [[ "$DESKTOP" = "1" ]]; then
    plugins=(colored-man-pages extract safe-paste sudo zsh-interactive-cd zsh-syntax-highlighting)
else
    plugins=(zsh-syntax-highlighting)
fi

source $ZSH/oh-my-zsh.sh

. ~/.zsh/.zshaliases
if [[ "$DESKTOP" = "1" ]]; then
    . ~/.zsh/.zshaliases_desktop
else
    . ~/.zsh/.zshaliases_mobile
fi

if [[ "$DESKTOP" = "1" ]]; then
    . ~/.zsh/.zshprompt_desktop
else
    . ~/.zsh/.zshprompt_mobile
fi

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # load nvm
export NODE_PATH=$(npm root -g) # has to be after nvm is loaded