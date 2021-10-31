#!/bin/zsh

alias zshrc='nano ~/.zshrc'

pyc() {
    python3 -c "print($1)"
}
pye() {
    python3 -c "$1"
}

alias cat='bat --paging=never'
alias qr='qrencode -m 2 -t utf8 <<< "$1"'
alias record='asciinema rec'
alias myip='curl http://ipecho.net/plain; echo'
alias passgen='pwgen -cnys1 "--remove-chars=;['\''\\\"" 16 3'
alias allpkgs='dpkg --get-selections | grep -v deinstall'
alias toppkgs='apt-mark showmanual |\
                sort |\
                grep -v -F -f <(apt show $(apt-mark showmanual) 2> /dev/null |\
                grep -e ^Depends -e ^Pre-Depends |\
                sed '\''s/^Depends: //; s/^Pre-Depends: //; s/(.*)//g; s/:any//g'\'' |\
                tr -d '\'',|'\'' |\
                tr '\'' '\'' '\''\n'\''|\
                grep -v ^$ |\
                sort -u)'
alias dropcache='sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"'
alias youtube-dl="youtube-dl --add-metadata -i -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4"

quote() {
    pyc '__import__("re").sub("'\''", "'\''\\\\'\'\''", r"""'$1'""")'
    #                        ("  ' ", "  ' \ \   ' ' ", r""" $1 """)
    #                        ("'",    "'\\''",          r"""$1""")
}
alias load='<'

alias ls='lsd --group-dirs first'
alias l='ls -l'
alias la='ls -A'
alias lla='ls -lA'
alias lt='ls --tree'
alias lls='l --total-size -S'
alias las='lls -A'
alias /='cd /'
alias cls='clear'

alias gitc='git clone'

bk() {
    cp "$1" "$1.bak"
}
backup() {
    D=$(date +"%Y-%m-%d-%H-%M-%S")
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

alias pip='pip3'
alias newpyenv='virtualenv env && source ./env/bin/activate'
alias pinstall='pip install'

# load platform specific aliases
alias zshconfig='code ~/git-repos/dotfiles/zsh'

alias diskspace='sudo ncdu --exclude /mnt --exclude /proc /'
alias kspenv='. /home/paul/Programming/KSP/interface/kspenv/bin/activate'
alias rustscan='docker run -it --rm --ulimit nofile=80000:80000 --name rustscan rustscan/rustscan:2.0.0 --scan-order "Random"'
alias nikto='docker run --rm --ulimit nofile=15000:15000 --name nikto sullo/nikto'
alias exiftool='~/.local/bin/exiftool'
