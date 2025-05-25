#
# Abbreviations
#

set -q MY_ABBRS_INITIALIZED; and return

abbr -a -- - 'cd -'

abbr -a -- cls clear
abbr -a -- ip 'ip --color=auto'

abbr -a -- rm 'rm -Iv --one-file-system'
abbr -a -- rmr 'rm -Irv --one-file-system'
abbr -a -- cp 'cp -iv'
abbr -a -- mv 'mv -iv'

abbr -a -- upd 'yay -Sy'
abbr -a -- i 'yay -S'
abbr -a -- upg 'yay -Syu'
abbr -a -- rem 'yay -Rs'
abbr -a -- autoremove 'sudo pacman -Qdtq | sudo pacman -Rns -'

abbr -a -- 7z-0 '7z a -mx0'
abbr -a -- 7z-zstd '7z a -mx3 -mm=ZSTD'
abbr -a -- 7z-zstdx '7z a -mx7 -mm=ZSTD'
abbr -a -- 7z-lzma '7z a -mx3 -mm=LZMA'
abbr -a -- 7z-lzmax '7z a -mx7 -mm=LZMA'
abbr -a -- 7zip-0 '7z a -tzip -mx0'
abbr -a -- 7zip '7z a -tzip -mx3'
abbr -a -- 7zipx '7z a -tzip -mx7'
abbr -a -- 7zip-zstd '7z a -tzip -mx5 -mm=ZSTD'
abbr -a -- 7zip-zstdx '7z a -tzip -mx15 -mm=ZSTD'
abbr -a -- 7tar '7z a -ttar'

abbr -a -- ls lsd
abbr -a -- l 'lsd -l'
abbr -a -- la 'lsd -A'
abbr -a -- lla 'lsd -lA'
abbr -a -- lt 'lsd --tree'
abbr -a -- lls 'lsd -l --total-size -S'
abbr -a -- las 'lsd -l --total-size -SA'

abbr -a -- ds 'date +%Y-%m-%d'
abbr -a -- ts 'date +%Y-%m-%dT%H:%M:%SZ'
abbr -a -- yyyymmdd 'date +%Y%m%d'

# no need to run over-and-over
set -g MY_ABBRS_INITIALIZED true
