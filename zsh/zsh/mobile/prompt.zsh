#!/bin/zsh

powerline_precmd() {
    PS1=$(powerline-go\
     -shell zsh\
     -error $?\
     -max-width 70\
     -modules clock,venv,user,ssh,cwd,perms,git,exit,root\
     -hostname-only-if-ssh\
    )
}