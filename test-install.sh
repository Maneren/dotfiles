#!/bin/sh

docker run -w /dotfiles -v "$(pwd):/dotfiles" manjarolinux/base ./install.sh
# docker run -w /dotfiles -v "$(pwd):/dotfiles" manjarolinux/base sh -c "curl -fsSL bit.ly/maneren-install | bash -"
