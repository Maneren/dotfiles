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
_load_nvm () {
    if [[ $NVM_LOADED = "true" ]]; then
        return
    fi
    
    echo loading nvm
    export NVM_LOADED=true
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
}
nvm() {
    unset -f nvm
    _load_nvm
    nvm "$@"
}
node() {
    unset -f node
    _load_nvm
    node "$@"
}
npm() {
    unset -f npm
    _load_nvm
    npm "$@"
}
npx() {
    unset -f npx
    _load_nvm
    npx "$@"
}

if [[ "$DESKTOP" = "1" ]]; then
    plugins=(colored-man-pages extract kate sudo zsh-interactive-cd zsh-syntax-highlighting)
else
    plugins=(kate zsh-syntax-highlighting)
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

if [[ -n "$ZSH_COMPDUMP"(#qN.mh+12) ]]; then
    compinit -u "$ZSH_COMPDUMP"
    touch "$ZSH_COMPDUMP"
else
    compinit -C "$ZSH_COMPDUMP"
fi

