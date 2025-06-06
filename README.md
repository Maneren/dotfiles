# My Dotfiles

My dotfiles repo for ZSH, Fish and various CLI tools based on [GNU Stow](https://www.gnu.org/software/stow/).

![preview](./preview.png)

## Branches

- main – Manjaro on desktop and partially on WSL 2
- wsl – Ubuntu on WSL 2 and on Termux (_archived_)
- pop – Pop!\_OS desktop (_archived_)

## Install

> [!CAUTION]
> Don't blindly install this! Read through the files and backup your original
> dotfiles first. Especially the shell configuration files contain many options
> specific to my system that can mess up your shell (e.g. `$PATH`) or even parts
> of the DE if you have too different installation. Additionally, `zsh`, `fish`
> and `nvim` will start automatically downloading plugins on the first startup;
> review them as well.

### Dotfiles

Run `stow --dotfiles -t ~ dotfiles`

### Software

See [SOFTWARE.md](SOFTWARE.md) for a list of software I use in or along this config.
