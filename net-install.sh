#!/bin/sh

if ! command -v git >/dev/null 2>&1; then
  echo "Git must be installed"
  exit 1
fi

git clone https://github.com/Maneren/dotfiles ~/git-repos/dotfiles
cd ~/git-repos/dotfiles || exit 1
./install.sh
