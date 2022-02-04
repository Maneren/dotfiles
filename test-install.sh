#!/bin/sh

docker run -w /dotfiles -v "$(pwd):/dotfiles" manjarolinux/base ./install.sh