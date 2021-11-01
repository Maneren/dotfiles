#!/bin/zsh

pyc() {
    python3 -c "print($1)"
}
pye() {
    python3 -c "$1"
}

alias bat='bat --paging=never'
alias qr='qrencode -m 2 -t utf8 <<< "$1"'
alias record='asciinema rec'
alias myip='curl http://ipecho.net/plain; echo'
alias dropcache='sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"'

quote() {
    pyc '__import__("re").sub("'\''", "'\''\\\\'\'\''", r"""'$1'""")'
    #                        ("  ' ", "  ' \ \   ' ' ", r""" $1 """)
    #                        ("'",    "'\\''",          r"""$1""")
}

alias ls='lsd --group-dirs first'
alias l='ls -l'
alias la='ls -A'
alias lla='ls -lA'
alias lt='ls --tree'
alias lls='l --total-size -S'
alias las='lls -A'

alias cls='clear'

alias gitc='git clone'

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

alias update='sudo pacman -Sy'
alias install='sudo pacman -S'
alias upgrade='sudo pacman -Syu'
alias remove='sudo pacman -Rs'

alias upd='update'
alias i='install'
alias upg='upgrade'
alias rem='remove'

alias autoremove='pacman -Qdtq | pacman -Rns -'

alias reload='exec zsh'
alias relaod='reload'

mkcd() {
    mkdir "$1"
    cd "$1" || return
}

pyenv() {
    local name="$1"

    if [ -z "$name" ]; then
        name="env"
    fi

    virtualenv "$name" && source "./$name/bin/activate"
}

alias pip='pip3'
alias kspenv='. /home/paul/Programming/KSP/interface/kspenv/bin/activate'
alias rustscan='docker run -it --rm --ulimit nofile=80000:80000 --name rustscan rustscan/rustscan:2.0.0 --scan-order "Random"'
alias nikto='docker run --rm --ulimit nofile=15000:15000 --name nikto sullo/nikto'
