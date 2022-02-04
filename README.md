# dotfiles

My dotfiles repo for zsh + OMZ, git and bash (bash is just an unmaintained backup of old files)

[preview](https://github.com/Maneren/dotfiles/blob/master/preview.png)

## Branches

- master - Manjaro desktop
- pop - Pop!\_OS desktop - *deprecated*
- wsl - Ubuntu on WSL2 and on Termux - *currently unmaintained, getting to it*

## Install

Just run

```sh
curl -fsSL rebrand.ly/maneren-install | sh -
```

install.sh creates symlinks according to this pattern:

- ~/.zshrc => dotfiles/zsh/.zshrc
- ~/.dotfiles/zsh/ => dotfiles/zsh/zsh/
- ...
