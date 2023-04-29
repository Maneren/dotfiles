#!/bin/zsh

pyc() {
    python3 -c "print($1)"
}
pye() {
    python3 -c "$1"
}

pyenv() {
    local name="$1"

    [ -z "$name" ] && name=".venv"

    if [ -d "./$name" ]; then
        source "./$name/bin/activate"
    else
        virtualenv "$name" && source "./$name/bin/activate"
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
        nvim "$target"
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

    if [ -z "$url" ]; then
        echo "Usage: gitc <url>"
        return 1
    fi

    if [[ $url = Maneren/* || $url != */* ]]; then
        git clone "git@github.com:Maneren/${1#Maneren/}"
    elif [[ $url = ssh:* ]]; then
        git clone "git@github.com:${1#ssh:}"
    else
        git clone "$1"
    fi
}

bk() {
    cp "$1" "$1.bak"
}
backup() {
    D=$(date +"%Y-%m-%d-%H-%M")
    for file in "$@"; do
        cp "$file" "$file.T.$D.bak"
        echo "copied to $file.T.$D.bak"
    done
}

alias upd='sudo pacman -Sy'
alias i='sudo pacman -S'
alias upg='sudo pacman -Syu'
alias rem='sudo pacman -Rs'

alias autoremove='sudo pacman -Qdtq | sudo pacman -Rns -'

alias reload='exec zsh'
alias relaod='reload'

mkcd() {
    mkdir "$1"
    cd "$1" || return
}

alias npx='pnpm dlx'

alias '7z-zstd'='7z a -mx3 -mm=ZSTD'
alias '7z-zstdx'='7z a -mx7 -mm=ZSTD'
alias '7z-lzma'='7z a -mx3 -mm=LZMA'
alias '7zip-store'='7z a -tzip -mx0'
alias '7zip-0'='7z a -tzip -mx0'
alias '7zip-deflate'='7z a -tzip -mx3'
alias '7zip-zstd'='7z a -tzip -mx3 -mm=ZSTD'
alias '7zip-zstdx'='7z a -tzip -mx7 -mm=ZSTD'
alias '7tar'='7z a -ttar'
