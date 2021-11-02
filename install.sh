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
    if [ -d "$1" ]; then
        echo "$1 already downloaded"
    else
        echo "Downloading $1"
        git clone --depth 1 -- "https://github.com/$2"
        echo
    fi
}

main() {
    local required_packages="curl fzf git go python3 python-pip rustup zsh"

    read -rp "Install required pkgs: ($required_packages) ? (Y/n) " yn
    [[ ! "$yn" == [Nn] ]] && eval "sudo pacman -Syu --needed $required_packages"

    echo

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

    (
        mkdir -p ~/git-repos
        cd ~/git-repos || exit

        git_clone "powerline-go" Maneren/powerline-go

        cd powerline-go || exit

        go build

        mkdir -p ~/.local
        mkdir -p ~/.local/bin
        mv powerline-go ~/.local/bin
    )

    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo Downloading OMZ
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -- --unattended
    else
        echo OMZ already installed
    fi

    (
        cd ~/.oh-my-zsh/custom/plugins || exit

        git_clone "alias-tips" djui/alias-tips
        git_clone "zsh-interactive-cd" changyuheng/zsh-interactive-cd
        git_clone "zsh-syntax-highlighting" zsh-users/zsh-syntax-highlighting
        git_clone "zsh-autocomplete" marlonrichert/zsh-autocomplete
        git_clone "zsh-autosuggestions" zsh-users/zsh-autosuggestions
    )

    echo

    copy_and_link_files
    exec zsh
}

main
