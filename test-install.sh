#!/bin/sh

docker build -t dotfiles .

docker run \
-w /home/test_user/Downloads/dotfiles \
-v "$(pwd):/home/test_user/Downloads/dotfiles" \
dotfiles \
./install.sh
