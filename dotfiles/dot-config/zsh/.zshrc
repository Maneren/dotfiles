# if we have fish, run it
if which fish >/dev/null; then
    source $ZDOTDIR/env.zsh
    exec fish
fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $ZDOTDIR/env.zsh

# custom aliases
source $ZDOTDIR/aliases.zsh

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

OMZPs=(cp encode64 fzf globalias rsync sudo)
OMZLs=(history completion clipboard directories functions)

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
    Magniquick/fzf-tab-source \
    romkatv/powerlevel10k

zicompinit

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

eval "$(fnm env --shell zsh)"
eval "$(fnm completions --shell zsh)"
eval "$(uv generate-shell-completion zsh)"
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

source $ZDOTDIR/p10k.zsh
