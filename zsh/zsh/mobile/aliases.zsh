#!/bin/zsh

alias diskspace='sudo ncdu\
--exclude /mnt\
--exclude /proc\
--exclude /storage\
--exclude /data\
--exclude /sdcard\
--exclude /sys\
--exclude /system\
--exclude /dev\
--exclude /vendor\
/'
