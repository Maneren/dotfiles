#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

shopt -s dotglob
shopt -s extglob

for dir in "$CURRENT_DIR"/!(".git"|".."|"."); do
    test -d "$dir" || continue
    echo "Setting up $(basename "$dir")"
    
    for item in "$dir"/!(".."|"."); do
        # test -f "$item" || continue
        echo "$HOME/$(basename "$item")"
        rm -ir "${HOME:?}/$(basename "$item")"
        ln -s "$item" ~/
    done
done