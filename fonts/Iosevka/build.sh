#!/bin/bash
npm i
npm run build ttf::iosevka-custom
docker run --rm -v "$PWD/dist/iosevka-custom/TTF:/in:z" -v "$PWD/dist/iosevka-custom-nf/TTF:/out:Z" nerdfonts/patcher
