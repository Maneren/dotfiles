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

alias dotfiles='code ~/git-repos/dotfiles'

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

quote() {
  pyc '__import__("re").sub("'\''", "'\''\\\\'\'\''", r"""'$1'""")'
  #                        ("  ' ", "  ' \ \   ' ' ", r""" $1 """)
  #                        ("'",    "'\\''",          r"""$1""")
}

exa_ls='exa -Fb --icons'
alias ls="$exa_ls --group-directories-first"
alias ll='ls -l'
alias l='ll'
alias la='ls -a'
alias lla='ll -a'
alias lt='ls -T'

exa_lls="$exa_ls -lrs size --color always"
alias lls="$exa_lls | grep -Ev '/$'"
alias las="$exa_lls -a | grep -Ev '/$'"

unset exa_ls exa_lls

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
