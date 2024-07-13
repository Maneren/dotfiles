#!/bin/bash
npm i
npm run build ttf::iosevka-custom
docker run --rm -v "$PWD/dist/iosevka-custom/TTY:/in:z" -v "$PWD/dist/iosevka-custom-nf/TTY:/out:Z" nerdfonts/patcher
