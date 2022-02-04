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
    echo -e "\e[31m$name already downloaded\e[0m"
  else
    echo -e "\e[31mDownloading $name\e[0m"
    git clone --depth 1 -q -- "https://github.com/$1" "$folder"
  fi
}

ARCH=$(uname -m)
if [ ! "$(uname -m)" = "aarch64" ] && [ ! "$(uname -m)" = "x86_64" ]; then
  echo -e "\e[31mUnsupported platform\e[0m"
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
  echo -e "\e[31mDownloading powerline-go\e[0m"
  curl 'https://github.com/justjanne/powerline-go/releases/download/latest/powerline-go-linux-arm64' -o ~/.local/bin/powerline-go
else
  packages_to_install+=(powerline-go)
fi

echo -e "\e[31mInstalling with pacman\e[0m"
sudo pacman -Sy --needed --noconfirm "${packages_to_install[@]}" || exit 1

echo -e "\e[31mInstalling rustup\e[0m"
rustup self upgrade-data
rustup install stable
cargo install lsd

pnpm="$(/bin/which pnpm 2>/dev/null)"
if [[ "$pnpm" == *"no pnpm in"* ]] || [ -z "$pnpm" ]; then
  echo -e "\e[31mDownloading pnpm\e[0m"
  curl -fsSL https://get.pnpm.io/install.sh | sh -
  
  export PNPM_HOME="$HOME/.local/share/pnpm"
  export PATH="$PNPM_HOME:$PATH"
else
  echo -e "\e[31mpnpm already installed\e[0m"
fi

echo -e "\e[31mInstalling NodeJS\e[0m"
pnpm config set store-dir ~/.cache/pnpm-store
pnpm store path
pnpm env use -g latest


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
  echo -e "\e[31mSwitching default shell to zsh\e[0m"
  
  zsh=/bin/zsh
  
  chsh -s "$zsh"
  export SHELL="$zsh"
fi

exec zsh

