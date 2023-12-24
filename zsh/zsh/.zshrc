#!/bin/zsh

# custom aliases and prompt
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/prompt.zsh

### Added by Zinit's installer
source "$XDG_DATA_HOME/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
### End of Zinit's installer chunk

zinit ice as"completion" for \
    snippet OMZP::fd/_fd \
    snippet OMZP::adb/_adb

OMZPs=(command-not-found cp encode64 fzf globalias rsync sudo)
OMZLs=(history completion clipboard directories)

for OMZP ($OMZPs); do; zinit snippet OMZP::$OMZP; done
for OMZL ($OMZLs); do; zinit snippet OMZL::$OMZL.zsh; done

zinit light-mode depth"1" for \
    djui/alias-tips \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions \
    zsh-users/zsh-history-substring-search \
    zdharma-continuum/fast-syntax-highlighting \
    make'download' Maneren/zsh-interactive-cd

zicompinit

# switch to vi mode
bindkey -v

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# make Home and End keys work
bindkey -v '^[[H' beginning-of-line
bindkey -v '^[[F' end-of-line

# fix backspace key
bindkey -v '^?' backward-delete-char

zic-setup '^I'

# change cursor based on normal/insert mode
function zle-keymap-select {
    case ${KEYMAP-} in
        vicmd | visual) echo -ne '\e[1 q' ;;
        *) echo -ne '\e[6 q' ;;
    esac
}
zle -N zle-keymap-select

eval "$(fnm env --shell zsh)"
eval "$(fnm completions --shell zsh)"
eval "$(pyenv init - zsh)"
eval "$(pyenv virtualenv-init - zsh)"
