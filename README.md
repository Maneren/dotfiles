# Dotfiles

My dotfiles repo for ZSH and various CLI tools based on [GNU Stow](https://www.gnu.org/software/stow/).

![preview](https://github.com/user-attachments/assets/c7a7eef1-d560-4d9d-98e9-17d16841c7ed)

## Branches

- main - Manjaro desktop and partially WSL
- wsl - Ubuntu on WSL2 and on Termux - _archived_
- pop - Pop!\_OS desktop - _archived_

## Install

> [!CAUTION]
> Don't blindly install this, read through the files and backup your original
> dotfiles. Especially the `zsh` files contain system specific configuration that
> can mess up your shell (e.g. `$PATH`) or even parts of the DE if you have too
> different installation than I have. Additionally, `zsh` and `nvim` will start
> automatically downloading plugins on startup, review them as well!

### Dotfiles

Run `stow --dotfiles -t ~ dotfiles`
