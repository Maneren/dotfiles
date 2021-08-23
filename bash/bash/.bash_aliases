#!/bin/bash

alias ls='lsd --group-dirs first'
alias l='ls -l'
alias la='ls -A'
alias lla='ls -lA'
alias lt='ls --tree'
alias lls='l --total-size'
alias las='lla --total-size'

alias cls='clear'

alias edit-aliases='nano ~/.bash_aliases'

alias update='sudo apt-get update'
alias install='sudo apt-get install'
alias instally='install -y'
alias uinstall='update && install'
alias uinstally='update && instally'
alias upgrade='sudo apt-get upgrade'
alias upgradey='upgrade -y'
alias uupgrade='update && upgrade'
alias uupgradey='update && upgradey'
alias remove='sudo apt-get remove'

alias upd='update'
alias i='install'
alias iy='instally'
alias ui='uinstall'
alias uiy='uinstally'
alias upg='upgrade'
alias upgy='upgradey'
alias uupg='uupgrade'
alias uupgy='uupgradey'
alias rem='remove'

alias reload='source ~/.bashrc'
