#!/bin/bash

git="$(/bin/which git 2>/dev/null)"
if [[ "$git" == *"no git in"* ]] || [ -z "$git" ]; then
  echo "Git must be installed"
  exit 1
fi

git clone https://github.com/Maneren/dotfiles ~/git-repos/dotfiles
~/git-repos/dotfiles/install.sh
