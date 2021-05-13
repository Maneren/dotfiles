#!/bin/zsh

export ARCHFLAGS="-arch x86_64"
export JOHN=/opt/tools/JohnTheRipper/run
export WIN_IP=$(route -n | grep "^0\.0\.0\.0" | awk '{print $2}')
export WIN_USERNAME=$(cmd.exe /c 'echo %USERNAME%' 2>/dev/null | dos2unix)

export DISPLAY_NUMBER="0.0"
export DISPLAY="$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}'):$DISPLAY_NUMBER"
export LIBGL_ALWAYS_INDIRECT=1

export VISUAL='kate'

