# dotfiles

My dotfiles repo for ZSH + OMZ, git and for bash (not really used, just a backup of old files)

[preview](https://github.com/Maneren/dotfiles/blob/master/preview.png)

The desktop version is for Ubuntu 20.04 on WSL2 and
the mobile version is for Ubuntu 20.04 on Termux

## Install

install.sh creates symlinks according to this pattern:
~/.bashrc => dotfiles/bash/.bashrc
~/.zshrc => dotfiles/zsh/.zshrc
~/.dotfiles/zsh/ => dotfiles/zsh/zsh/
...

## Direct dependencies

- zsh, oh-my-zsh
- zsh-syntax-highlighting
- powerline-go
- fzf

## Terminal

Desktop files are used in Windows Terminal with [this config](https://github.com/Maneren/WindowsTerminalConfig)
