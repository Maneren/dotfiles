#!/bin/bash

copy_and_link_files() {
  local CURRENT_DIR
  CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
  
  [ -d "$HOME/.dotfiles" ] || mkdir "$HOME/.dotfiles"
  
  local dirs
  dirs=$(find "$CURRENT_DIR" -maxdepth 1 -mindepth 1 -type d ! -regex '\(.*/.git\)')
  
  for dir in $dirs; do
    echo "Setting up $(basename "$dir")"
    
    local items
    items=$(find "$dir" -maxdepth 1 -mindepth 1)
    
    for item in $items; do
      name=$(basename "$item")
      
      if [ -f "$item" ]; then
        echo '~'"/$name => $item"
        
        local target_dir=$HOME
        local target=$target_dir/$name
        
        # if already correctly linked continue
        [ "$target" -ef "$item" ] && continue
        
        # if there is something else, prompt user to delete it
        [ -d "$target" ] && rm -ir "$target"
        [[ -L "$target" || -f "$target" ]] && rm "$target"
        
        ln -s "$item" ~/
        elif [ -d "$item" ]; then
        echo '~'"/.dotfiles/$name/ => $item"
        
        local target_dir=$HOME/.dotfiles
        local target=$target_dir/$name
        
        # if already correctly linked continue
        [ "$target" -ef "$item" ] && continue
        
        # if there is something else, prompt user to delete it
        [ -d "$target" ] && rm -ri "$target"
        [[ -L "$target" || -f "$target" ]] && rm -i "$target"
        
        ln -s "$item" "$target"
      fi
    done
    
    printf "\n"
  done
}

git_clone() {
  local name="${1#*/}"
  
  folder=$2
  if [ -z "$folder" ]; then
    folder=$name
  fi
  
  if [ -d "$name" ]; then
    echo "$name already downloaded"
  else
    echo "Downloading $name"
    git clone --depth 1 -q -- "https://github.com/$1" "$folder"
  fi
}

ARCH=$(uname -m)
if [ ! "$(uname -m)" = "aarch64" ] && [ ! "$(uname -m)" = "x86_64" ]; then
  echo Unsupported platform
  exit 1
fi

echo
echo "Installing Maneren's dotfiles"
echo
echo

cd /tmp || exit 1
mkdir -p ~/.local/bin ~/.local/shared ~/git-repos

packages_to_install=(asciinema bat fzf git neovim python3 python-pip rustup zsh)

if [ "$ARCH" = "aarch64" ]; then
  echo Downloading powerline-go
  curl 'https://github.com/justjanne/powerline-go/releases/download/latest/powerline-go-linux-arm64' -o ~/.local/bin/powerline-go
else
  packages_to_install+=(powerline-go)
fi

sudo pacman -Sy --needed --noconfirm "${packages_to_install[@]}" || exit 1

rustup self upgrade-data
rustup install stable
cargo install lsd

pnpm="$(/bin/which pnpm 2>/dev/null)"
if [[ "$pnpm" == *"no pnpm in"* ]] || [ -z "$pnpm" ]; then
  echo Downloading pnpm
  curl -fsSL https://get.pnpm.io/install.sh | sh -
  
  export PNPM_HOME="$HOME/.local/share/pnpm"
  export PATH="$PNPM_HOME:$PATH"
  
  
  echo Installing NodeJS
  pnpm config set store-dir ~/.cache/pnpm-store
  pnpm store path
  pnpm env use -g latest
else
  echo pnpm already installed
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  git_clone "ohmyzsh/ohmyzsh" ~/.oh-my-zsh
fi

(
  cd ~/.oh-my-zsh/custom/plugins || exit
  
  git_clone "djui/alias-tips"
  git_clone "zsh-users/zsh-autosuggestions"
  git_clone "zsh-users/zsh-completions"
  git_clone "Maneren/zsh-interactive-cd"
  git_clone "zsh-users/zsh-syntax-highlighting"
)

echo

copy_and_link_files

if [ ! "$(basename -- "$SHELL")" = "zsh" ]; then
  echo "Switching default shell to zsh"
  
  zsh=/bin/zsh
  
  chsh -s "$zsh"
  export SHELL="$zsh"
fi

exec zsh

