#!/bin/zsh

alias zshconfig='code ~/git-repos/dotfiles/zsh'

alias bpytop='source ~/.venvs/bpytop/bin/activate && bpytop && deactivate'
alias diskspace='sudo ncdu --exclude /mnt --exclude /proc /'
alias kspenv='. /home/paul/Programming/KSP/interface/kspenv/bin/activate'
alias rustscan='docker run -it --rm --ulimit nofile=80000:80000 --name rustscan rustscan/rustscan:2.0.0 --scan-order "Random"'
alias nikto='docker run --rm --ulimit nofile=15000:15000 --name nikto sullo/nikto'
alias exiftool='~/.local/bin/exiftool'

discord-rcp () {
    local process=$(pgrep -af 'init' | grep --color=never 'easyrp.exe')
    if [ $@ = '-d'* ]; then
        if [ -z $process ]; then
            echo not running
            return
        fi
        
        local pid=$(echo $process | sed 's/[^0-9]*//g')
        echo killing $pid
        kill -kill $pid
        return
    fi
    (
        cd ~/.local/EasyRP/
        if [ -z $process ]; then
            echo starting
            python config.py "$@"
            ./easyrp.exe &
        else
            echo changing config
            python config.py -r "$@"
        fi
    )
}

john () {
    (
        cp "$1" "$JOHN/files"
        cd "$JOHN" || return
        ./john.exe "files/$(basename "$1")" "${@:2}"
    )
}

hashcat () {
    (
        cd "$HOME/.local/hashcat" || return
        ./hashcat64.exe "$*"
    )
}

firefox () {
    command firefox "$*" &>/dev/null &
}
