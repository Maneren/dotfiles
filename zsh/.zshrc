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

# lazy load nvm
. ~/.zsh/.nvm_lazyload

if [[ "$DESKTOP" = "1" ]]; then
    plugins=(colored-man-pages extract kate sudo zsh-interactive-cd zsh-syntax-highlighting)
else
    plugins=(sudo zsh-syntax-highlighting)
fi

. $ZSH/oh-my-zsh.sh

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
