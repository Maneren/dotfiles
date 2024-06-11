#!/bin/zsh

source $ZDOTDIR/env.zsh

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

OMZLs=(history completion clipboard directories)
OMZPs=(cp encode64 fzf globalias rsync sudo)

for OMZP ($OMZPs); do; zinit snippet OMZP::$OMZP; done
for OMZL ($OMZLs); do; zinit snippet OMZL::$OMZL.zsh; done

zinit light-mode depth"1" for \
    djui/alias-tips \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions \
    zsh-users/zsh-history-substring-search \
    jeffreytse/zsh-vi-mode \
    zdharma-continuum/fast-syntax-highlighting \
    Aloxaf/fzf-tab \
    Magniquick/fzf-tab-source

zicompinit

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

eval "$(fnm env --shell zsh)"
eval "$(fnm completions --shell zsh)"
eval "$(pyenv init - zsh)"
eval "$(pyenv virtualenv-init - zsh)"
eval "$(zoxide init zsh --cmd cd)"
GLOBALIAS_FILTER_VALUES=(cd)
export LS_COLORS="$(vivid generate catppuccin-mocha)"

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd --color=always -1 $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:complete:tldr:argument-1' fzf-preview 'tldr --color $word'
