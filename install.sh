#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

shopt -s dotglob
shopt -s extglob

for dir in "$CURRENT_DIR"/!(".git"|".."|"."); do
    
    test -d "$dir" || continue
    echo "Setting up $(basename "$dir")"
    
    for item in "$dir"/!(".."|"."); do
        name=$(basename "$item")
        
        if [[ -f "$item" ]]; then
            echo '~'"/$name => $item"
        else
            echo '~'"/$name/ => $item"
        fi
        
        if [ "$HOME/$name" -ef "$item" ]; then
            continue
        fi
        
        if [[ -L "$HOME/$name" || -f "$HOME/$name" ]]; then
            rm -i "${HOME:?}/$name"
        fi
        
        if [[ -d "$HOME/$name" ]]; then
            rm -ir "${HOME:?}/$name"
        fi
        
        ln -s "$item" ~/
    done
    
    printf "\n"
done