#!/bin/zsh

# env for interactive shells

_comp_options+=(globdots)   # include hidden files in completion
_comp_options+=(nocaseglob) # case insensitive globbing

setopt interactivecomments
setopt long_list_jobs
setopt extended_glob

export TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'
