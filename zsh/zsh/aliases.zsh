#!/bin/zsh

alias zshrc='nano ~/.zshrc'

pyc () {
    python3 -c "print($1)"
}
pye () {
    python3 -c "$1"
}

alias qr='qrencode -m 2 -t utf8 <<< "$1"'
alias record='asciinema rec'
alias myip='curl http://ipecho.net/plain; echo'
alias passgen='pwgen -cnys1 "--remove-chars=;['\''\\\"" 16 3'
alias allpkgs='dpkg --get-selections | grep -v deinstall'
alias toppkgs='comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n "s/^Package: //p" | sort -u)'
alias dropcache='sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"'
alias youtube-dl="youtube-dl --add-metadata -i -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4"

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

bk () {
    cp "$1" "$1.bak";
}
backup () {
    D=$(date +"%Y-%m-%d-%H-%M-%S");
    for file in "$@"
    do
        cp "$file" "$file.T.$D.bak";
        echo "copied to $file.T.$D.bak";
    done
}

alias update='sudo apt-get update'
alias install='sudo apt-get install'
alias instally='install -y'
alias uinstall='update && install'
alias uinstally='update && instally'
alias upgrade='sudo apt-get upgrade'
alias upgradey='upgrade -y'
alias uupgrade='update && upgrade'
alias uupgradey='update && upgradey'
alias remove='sudo apt-get remove'

alias upd='update'
alias i='install'
alias iy='instally'
alias ui='uinstall'
alias uiy='uinstally'
alias upg='upgrade'
alias upgy='upgradey'
alias uupg='uupgrade'
alias uupgy='uupgradey'
alias rem='remove'

alias list-upgrade='apt list --upgradeable'
alias lsupg='list-upgrade'

alias autoremove='sudo apt-get autoremove'
alias autopurge="dpkg --get-selections | awk '"'$2 == "deinstall" {print $1}'"' | xargs sudo apt-get purge"

alias reload='exec zsh'
alias relaod='reload'

mkcd () {
    mkdir "$1"
    cd "$1" || return
}

alias pip='pip3'
alias newpyenv='virtualenv env && source ./env/bin/activate'
alias pinstall='pip install'

# load platform specific aliases
source $_dotzsh_subfolder/aliases.zsh
