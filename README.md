# dotfiles

My dotfiles repo for zsh + OMZ, git and bash (bash is just a backup of old files)

[preview](https://github.com/Maneren/dotfiles/blob/master/preview.png)

## Branches

- master - Manjaro desktop
- pop - Pop!\_OS desktop - *deprecated*
- wsl - Ubuntu on WSL2 and on Termux - *unmaintained*

## Install

Just run

```sh
curl -fsSL bit.ly/maneren-install | bash -
```

install.sh creates symlinks according to this pattern:

- ~/.zshrc => dotfiles/zsh/.zshrc
- ~/.dotfiles/zsh/ => dotfiles/zsh/zsh/
- ...

## Pacman dependencies

- asciinema
- bat
- curl
- fzf
- git
- neovim
- powerline-go
- python3, python-pip
- rustup
- zsh
