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

update-plugins() {
  find "$ZSH_CUSTOM" -name .git -type d -exec sh -c 'echo "Updating $(basename "$(readlink -f "{}/..")")"; git -C "{}/.." pull' \;
}

update-self() {
  echo "Updating dotfiles"
  git -C ~/git-repos/dotfiles pull
}

update-zsh() {
  omz update
  update-plugins
  update-self
}

update-all() {
  pacman -Syu
  yay -Syu
}

quote() {
  pyc '__import__("re").sub("'\''", "'\''\\\\'\'\''", r"""'$1'""")'
  #                        ("  ' ", "  ' \ \   ' ' ", r""" $1 """)
  #                        ("'",    "'\\''",          r"""$1""")
}

base_ls='exa -Fb --icons'
alias ls="$base_ls --group-directories-first"
alias ll='ls -l'
alias l='ll'
alias la='ls -a'
alias lla='ll -a'
alias lt='ls -T'

base_lls="$base_ls -lrs size --color always"
alias lls="$base_lls | egrep -v '/$'"
alias las="$base_lls -a | egrep -v '/$'"

alias cls='clear'

gitc() {
  git clone "https://github.com/$1"
}
gitcssh() {
  git clone "git@github.com:Maneren/$1"
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

alias autoremove='pacman -Qdtq | pacman -Rns -'

alias reload='exec zsh'
alias relaod='reload'

mkcd() {
  mkdir "$1"
  cd "$1" || return
}

alias npx='pnpm dlx'
