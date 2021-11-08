# dotfiles

My dotfiles repo for ZSH + OMZ, git and for bash (not really used, just a backup of old files)

[preview](https://github.com/Maneren/dotfiles/blob/master/preview.png)

## Branches

- master - Manjaro desktop
- pop - Pop!\_OS desktop
- wsl - Ubuntu on WSL2 and on Termux

## Install

install.sh creates symlinks according to this pattern:
~/.bashrc => dotfiles/bash/.bashrc
~/.zshrc => dotfiles/zsh/.zshrc
~/.dotfiles/zsh/ => dotfiles/zsh/zsh/
...

## Pacman dependencies

- curl
- fzf
- git
- powerline-go
- python3, python-pip
- rustup
- zsh
