#!/bin/zsh

alias zshrc='nano ~/.zshrc'

pyc () {
    python3 -c "print($1)"
}
pye () {
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

quote () {
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
alias autopurge='sudo apt-get purge $(dpkg -l | grep "^rc" | awk '\''{print $2}'\'')'

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
alias zshconfig='code ~/git-repos/dotfiles/zsh'

alias bpytop='source ~/.venvs/bpytop/bin/activate && bpytop && deactivate'
alias diskspace='sudo ncdu --exclude /mnt --exclude /proc /'
alias kspenv='. /home/paul/Programming/KSP/interface/kspenv/bin/activate'
alias rustscan='docker run -it --rm --ulimit nofile=80000:80000 --name rustscan rustscan/rustscan:2.0.0 --scan-order "Random"'
alias nikto='docker run --rm --ulimit nofile=15000:15000 --name nikto sullo/nikto'
alias exiftool='~/.local/bin/exiftool'
