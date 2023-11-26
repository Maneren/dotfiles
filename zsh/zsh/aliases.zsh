#!/bin/zsh

pyc() {
    python3 -c "print($1)"
}
pye() {
    python3 -c "$1"
}

pyvenv() {
    local name="$1"

    eval "$(pyenv virtualenv-init -)"

    [ -z "$name" ] && name="main"

    if pyenv virtualenvs | grep "$name" >/dev/null; then
        pyenv activate "$name"
    else
        pyenv virtualenv "$name" && pyenv activate "$name"
    fi
}

pashare() {
    case "$1" in
        start)
            pashare stop >/dev/null 2>&1
            pactl load-module module-null-sink sink_name=rtp format=s16be channels=2 rate=48000
            pactl load-module module-rtp-send source=rtp.monitor destination=224.0.0.56 port=4010 mtu=320
            ;;
        stop)
            pactl unload-module module-null-sink
            pactl unload-module module-rtp-send
            ;;
        *)
            echo "Usage: $0 start|stop" >&2
            ;;
    esac
}

nv() {
    local target="$1"

    local work_dir
    if [[ -f "$target" ]]; then
        work_dir="$(dirname "$1")"
    else
        work_dir="$target"
    fi

    (
        cd "$work_dir"
        neovide --multigrid "$target"
    )
}
alias dotfiles='nv ~/git-repos/dotfiles'

alias docker-enable-qemu='docker run --rm --privileged multiarch/qemu-user-static --reset -p yes'

alias bat='bat --paging=never'
alias batp='bat --paging=always'
alias qr='qrencode -m 2 -t utf8 <<< "$1"'
alias record='asciinema rec'
alias dropcache='echo 3 | sudo tee /proc/sys/vm/drop_caches'

# TODO: expand this
alias monitor='watch -n 1 "echo -e '\''\n\nCore clocks>=3xxx\n\n'\'' && cat /proc/cpuinfo | grep -P '\'': [3]\d{3}'\''"'

update-zsh() {
    echo "Updating dotfiles"
    git -C ~/git-repos/dotfiles pull
    zinit update --all
    exec zsh
}

alias ls='lsd --group-dirs first'
alias l='ls -l'
alias la='ls -A'
alias lla='ls -lA'
alias lt='ls --tree'
alias lls='l --total-size -S'
alias las='lls -A'

alias cls='clear'

gitc() {
    local url="$1"
    shift

    if [ -z "$url" ]; then
        echo "Usage: gitc <url>"
        return 1
    fi

    if [[ $url = Maneren/* || $url != */* ]]; then
        git clone "git@github.com:Maneren/${url#Maneren/}" $@
    elif [[ $url = ssh:* ]]; then
        git clone "git@github.com:${url#ssh:}" $@
    else
        git clone "$url" $@
    fi
}

bk() {
    for file in "$@"; do
        cp -r "$file" "$file.bak"
    done
}
backup() {
    D=$(date +"%Y-%m-%d-%H-%M")
    for file in "$@"; do
        cp -r "$file" "$file.T.$D.bak"
        echo "copied '$file' to '$file.T.$D.bak'"
    done
}

remove-empty-dirs() {
    local target="$1"
    [ -z "$target" ] && target="."

    local directories
    directories=$(find "$target" -type d -empty)

    if [ -z "$directories" ]; then
        echo "No empty directories found"
        return 0
    fi

    echo Found empty directories:
    echo "$directories"

    read -q "REPLY?Delete? [y/N] " -n -k 1
    echo

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Deleting"
        find "$target" -type d -empty -delete
    fi
}

alias rm='rm -Iv --one-file-system'
alias cp='cp -nv'
alias mv='mv -nv'

alias upd='yay -Sy'
alias i='yay -S'
alias upg='yay -Syu'
alias rem='yay -Rs'

alias autoremove='sudo pacman -Qdtq | sudo pacman -Rns -'

alias reload='exec zsh'
alias relaod='reload'

mkcd() {
    mkdir "$1"
    cd "$1" || return
}

alias npx='pnpm dlx'

alias '7z-0'='7z a -mx0'
alias '7z-zstd'='7z a -mx3 -mm=ZSTD'
alias '7z-zstdx'='7z a -mx7 -mm=ZSTD'
alias '7z-lzma'='7z a -mx3 -mm=LZMA'
alias '7z-lzmax'='7z a -mx7 -mm=LZMA'
alias '7zip-0'='7z a -tzip -mx0'
alias '7zip'='7z a -tzip -mx3'
alias '7zipx'='7z a -tzip -mx7'
alias '7zip-zstd'='7z a -tzip -mx5 -mm=ZSTD'
alias '7zip-zstdx'='7z a -tzip -mx15 -mm=ZSTD'
alias '7tar'='7z a -ttar'
