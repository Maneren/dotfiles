#!/bin/sh

docker run -w /dotfiles -v "$(pwd):/dotfiles" manjarolinux/base ./install.sh
# docker run manjarolinux/base sh -c "curl -fsSL rebrand.ly/maneren-install | sh -"
