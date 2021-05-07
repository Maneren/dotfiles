#!/bin/bash

shopt -s dotglob
shopt -s extglob

main() {
    local CURRENT_DIR
    CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
    
    [[ -d "$HOME/.dotfiles" ]] || mkdir "$HOME/.dotfiles"
    
    for dir in "$CURRENT_DIR"/!(".git"|".."|"."); do
        
        test -d "$dir" || continue
        echo "Setting up $(basename "$dir")"
        
        for item in "$dir"/!(".."|"."); do
            name=$(basename "$item")
            
            
            
            if [[ -f "$item" ]]; then
                echo '~'"/$name => $item"
                
                local target_dir=$HOME
                local target=$target_dir/$name
                
                # if already correctly linked continue
                [ "$target" -ef "$item" ] && continue
                
                # if there is something else, prompt user to delete it
                [ -d "$target" ] && rm -ir "$target"
                [[ -L "$target" || -f "$target" ]] && rm -i "$target"
                
                ln -s "$item" ~/
            else
                echo '~'"/.dotfiles/$name/ => $item"
                
                local target_dir=$HOME/.dotfiles
                local target=$target_dir/$name
                
                # if already correctly linked continue
                [ "$target" -ef "$item" ] && continue
                
                # if there is something else, prompt user to delete it
                [ -d "$target" ] && rm -ir "$target"
                [[ -L "$target" || -f "$target" ]] && rm -i "$target"
                
                ln -s "$item" "$target"
            fi
        done
        
        printf "\n"
    done
}

main