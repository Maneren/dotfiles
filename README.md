# dotfiles

My dotfiles repo for zsh + OMZ

[preview](https://github.com/Maneren/dotfiles/blob/master/preview.png)

## Branches

- master - Manjaro desktop and Arch on Termux and WSL
- wsl - Ubuntu on WSL2 and on Termux - _archived_
- pop - Pop!\_OS desktop - _archived_

## Install

Installation script is now **DEPRECATED, use at your own risk**.

> **_NOTE:_** _works only for non root users but requires you to authorize sudo for pacman_

Either run from script

```sh
curl -fsSL rebrand.ly/maneren-install | bash -
```

or just clone the repo manually and run `./install.sh`

### What it does

Installs

- `asciinema`
- `bat`
- `diff-so-fancy`
- `lsd`
- `neovim`
- `yay`
- `pnpm` + downloads latest NodeJS
- `powerline-go`
- `python3` + `pip`
- `rustup` + installs stable and nightly toolchain
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

- ~/.zshrc => ./zsh/.zshrc
- ~/.zshenv => ./zsh/.zshenv
- ~/.dotfiles/zsh/ => ./zsh/zsh/
- ~/.bashrc => ./bash/.bashrc
- ...

and lastly sets zsh as the default shell
