#!/bin/bash

shopt -s dotglob
shopt -s extglob

copy_and_link_files() {
    local CURRENT_DIR
    CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
    
    [ -d "$HOME/.dotfiles" ] || mkdir "$HOME/.dotfiles"
    
    for dir in "$CURRENT_DIR"/!(".git"|".."|"."); do
        
        test -d "$dir" || continue
        echo "Setting up $(basename "$dir")"
        
        for item in "$dir"/!(".."|"."); do
            name=$(basename "$item")
            
            
            
            if [ -f "$item" ]; then
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

download_if_not_already() {
    if [ -d "$1" ]; then
        echo "$1 already downloaded"
    else
        echo "Downloading $1"
        git clone --depth 1 -- "$2"
    fi
}

main() {
    echo install prerequisites: sudo apt-get install curl fzf git golang nodejs python3 zsh
    echo optional packages: ncdu pwgen tmpreaper
    
    while true; do
        read -rp "Do you wish to proceed? (Y/n) " yn
        case $yn in
            [Nn]* ) exit;;
            * ) break;;
        esac
    done
    
    if [ "$(which rustup)" = "rustup not found" ]; then
        echo Downloading rustup
        curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path -y -q --default-host x86_64-unknown-linux-gnu --default-toolchain stable --profile minimal
    else
        echo Rustup alredy installed
    fi
    
    mkdir -p ~/.local
    mkdir -p ~/.local/bin
    
    mkdir -p ~/git-repos
    cd ~/git-repos || exit
    
    download_if_not_already "powerline-go" https://github.com/Maneren/powerline-go.git
    (
        cd powerline-go || exit
        go build
        mv powerline-go ~/.local/bin
    )
    
    if [ "$(which lsd)" = "lsd not found" ]; then
        echo Downloading lsd
        cargo install lsd
    else
        echo LSD alredy installed
    fi
    
    if [ -d "$HOME/.oh-my-zsh" ]; then
        echo OMZ already installed
    else
        echo Downloading OMZ
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
    fi
    
    cd ~/.oh-my-zsh/custom/plugins || exit
    download_if_not_already "zsh-interactive-cd" https://github.com/changyuheng/zsh-interactive-cd.git
    download_if_not_already "zsh-syntax-highlighting" https://github.com/zsh-users/zsh-syntax-highlighting.git
    download_if_not_already "alias-tips" https://github.com/djui/alias-tips.git
    download_if_not_already "zsh-autocomplete" https://github.com/marlonrichert/zsh-autocomplete.git
    
    cd ~/git-repos/dotfiles || exit
    
    copy_and_link_files
    exec zsh
}

main
