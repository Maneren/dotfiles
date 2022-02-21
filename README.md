# dotfiles

My dotfiles repo for zsh + OMZ, git and bash (bash is just an unmaintained backup of old files)

[preview](https://github.com/Maneren/dotfiles/blob/master/preview.png)

## Branches

- master - Manjaro desktop and RaspberryPI
- wsl - Ubuntu on WSL2 and on Termux - *currently unmaintained, slowly getting to it*
- pop - Pop!\_OS desktop - *archived*

## Install

> ***NOTE:*** *works only for non root users but requires you to authorize sudo for pacman*

```sh
curl -fsSL rebrand.ly/maneren-install | sh -
```

or just clone the repo manually and run `install.sh`

### What it does

Installs

- `asciinema`
- `bat`
- `fzf`
- `lsd`
- `neovim`
- `yay`
- `pnpm` + downloads latest NodeJS
- `powerline-go`
- `python3` + `python-pip`
- `rustup` + installs stable toolchain
- `zsh`
- OhMyZsh and plugins:
  - alias-tips
  - zsh-autosuggestions
  - zsh-completions
  - zsh-interactive-cd
  - zsh-syntax-highlighting
- CascadiaCode and JetBrainsMono nerd fonts
- Segoe UI font

the script then symlinks the dotfiles to user's home folder according to this pattern:

- ~/.zshrc          => ./zsh/.zshrc
- ~/.zshenv         => ./zsh/.zshenv
- ~/.dotfiles/zsh/  => ./zsh/zsh/
- ~/.bashrc         => ./bash/.bashrc
- ...

and lastly sets zsh as the default shell
