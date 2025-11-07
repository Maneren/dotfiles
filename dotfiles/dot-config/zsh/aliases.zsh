#!/bin/zsh

pyc() {
    python3 -c "print($1)"
}
pye() {
    python3 -c "$1"
}

pastop() {
    pactl unload-module module-null-sink
    pactl unload-module module-rtp-send
}

pastart() {
    pastop >/dev/null 2>&1
    pactl load-module module-null-sink sink_name=rtp format=s16be channels=2 rate=48000
    pactl load-module module-rtp-send source=rtp.monitor destination=224.0.0.56 port=4010 mtu=480
}

nv() {
    local target="$1"
    shift

    local work_dir
    if [[ -f "$target" ]]; then
        work_dir="$(dirname "$target")"
        target="$(basename "$target")"
    else
        work_dir="$target"
        target=""
    fi

    (
        cd "$work_dir"
        neovide "$target" "$@"
    )
}

alias dotfiles="$EDITOR ~/git-repos/dotfiles"

alias docker-enable-qemu='docker run --rm --privileged multiarch/qemu-user-static --reset -p yes'

alias pkgtop='pkgtop -pacman yay'

alias qr='qrencode -m 2 -t utf8 <<< "$1"'
alias record='asciinema rec'
alias dropcache='echo 3 | sudo tee /proc/sys/vm/drop_caches'

# make apps respect XDG
alias adb='HOME="$XDG_DATA_HOME"/android adb'
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"

alias ikill='ps aux | fzf -m | awk '\''{print $2}'\'' | xargs kill -9'

update-zsh() {
    echo "Updating dotfiles"
    git -C ~/git-repos/dotfiles pull
    zinit update --all
    exec zsh
}

alias ls='lsd'
alias l='ls -l'
alias la='ls -A'
alias lla='ls -lA'
alias lt='ls --tree'
alias lls='l --total-size -S'
alias las='lls -A'

alias cls='clear'

alias ip='ip --color=auto'

gitc() {
    local url="$1"
    shift

    if [ -z "$url" ]; then
        echo "Usage: gitc <url>"
        return 1
    fi

    if [[ $url = Maneren/* || $url != */* ]]; then
        url="git@github.com:Maneren/${url#Maneren/}"
    elif [[ $url = ssh:* ]]; then
        url="git@github.com:${url#ssh:}"
    fi

    echo "Cloning '$url'"
    git clone "$url" $@
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

yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
	    cd "$cwd"
	fi
	rm -f -- "$tmp"
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

watchpath() {
    local target="$1" callback="$2" target_event="$3"

    if [ -z "$target" ]; then
        echo "Usage: watchpath <target> [callback] [event]"
        return 1
    fi

    if [ -z "$callback" ]; then
        callback='echo ${file}: ${event}'
    fi

    if [ -z "$target_event" ]; then
        target_event="-e modify"
    elif [ "$target_event" = 'all' ]; then
        target_event=""
    elif [[ "$target_event" != '-e'* ]]; then
        target_event="-e $target_event"
    fi

    local folder name file output
    while true; do
        output=$(inotifywait -rq ${=target_event} "$target")

        read -r folder event name <<< "$output"

        if [ -n "$folder" ]; then
            file="$folder$name"
        else
            file="$folder"
        fi

        echo "$ ${(e)callback}"
        eval "$callback"
    done
}

alias rm='rm -Iv --one-file-system'
alias cp='cp -iv'
alias mv='mv -iv'

alias i='yay -S'
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
