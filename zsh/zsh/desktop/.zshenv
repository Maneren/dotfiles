#!/bin/zsh

export ARCHFLAGS="-arch x86_64"
export JOHN=/opt/tools/JohnTheRipper/run
export WIN_IP=$(route -n | grep "^0\.0\.0\.0" | awk '{print $2}')

export DISPLAY_NUMBER="0.0"
DISPLAY="$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}'):$DISPLAY_NUMBER"
export DISPLAY
export LIBGL_ALWAYS_INDIRECT=1

export VISUAL='kate'

