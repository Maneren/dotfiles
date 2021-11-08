#!/bin/bash

copy_and_link_files() {
    local CURRENT_DIR
    CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

    [ -d "$HOME/.dotfiles" ] || mkdir "$HOME/.dotfiles"

    local dirs
    dirs=$(find "$CURRENT_DIR" -maxdepth 1 -mindepth 1 -type d ! -regex '\(.*/.git\)')

    for dir in $dirs; do
        echo "Setting up $(basename "$dir")"

        local items
        items=$(find "$dir" -maxdepth 1 -mindepth 1)

        for item in $items; do
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
            elif [ -d "$item" ]; then
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

git_clone() {
    local name="${1#*/}"

    folder=$2
    if [ -z "$folder" ]; then
        folder=$name
    fi

    if [ -d "$name" ]; then
        echo "$name already downloaded"
    else
        echo "Downloading $name"
        git clone --depth 1 -q -- "https://github.com/$1" "$folder"
    fi
}

main() {
    local required_packages="curl fzf git powerline-go python3 python-pip rustup zsh"

    read -rp "Install required pkgs: ($required_packages) ? (Y/n) " yn
    [[ ! "$yn" == [Nn] ]] && eval "sudo pacman -Syu --needed $required_packages"

    echo

    rustup install stable

    local pnpm
    pnpm="$(which pnpm)"
    if [[ "$pnpm" == "which: no pnpm in"* ]] || [ -z "$pnpm" ]; then
        echo Downloading pnpm
        curl -fsSL https://get.pnpm.io/install.sh | sh -

        PNPM_HOME="$HOME/.local/share/pnpm"
        PATH="$PNPM_HOME:$PATH"

        echo Installing NodeJS
        pnpm env use -g latest
    else
        echo pnpm already installed
    fi

    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo Downloading OMZ
        git_clone "ohmyzsh/ohmyzsh" ~/.oh-my-zsh
    else
        echo OMZ already installed
    fi

    (
        cd ~/.oh-my-zsh/custom/plugins || exit

        git_clone "djui/alias-tips"
        git_clone "marlonrichert/zsh-autocomplete"
        git_clone "zsh-users/zsh-autosuggestions"
        git_clone "zsh-users/zsh-completions"
        git_clone "changyuheng/zsh-interactive-cd"
        git_clone "zsh-users/zsh-syntax-highlighting"
    )

    echo

    copy_and_link_files

    if [ ! "$(basename -- "$SHELL")" = "zsh" ]; then
        echo "Switching default shell to zsh"

        local zsh=/bin/zsh

        chsh -s "$zsh"
        export SHELL="$zsh"
    fi

    exec zsh
}

main
