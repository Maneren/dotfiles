#!/bin/bash

copy_and_link_files() {
  local CURRENT_DIR
  CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
  
  cd "$CURRENT_DIR" || exit 1
  
  mkdir -p ~/.dotfiles
  
  local dirs
  dirs=(bash git zsh) # folders to be linked
  
  for dir in "${dirs[@]}"; do
    echo "Setting up $(basename "$dir")"
    
    local items
    items=$(find "$dir" -maxdepth 1 -mindepth 1)
    
    for item in $items; do
      name="$(basename "$item")"
      
      if [ -f "$item" ]; then
        echo '~'"/$name => $item"
        
        local target_dir="$HOME"
        local target="$target_dir/$name"
        
        # if already correctly linked continue
        [ "$target" -ef "$item" ] && continue
        
        # if there is something else, prompt user to delete it
        [ -d "$target" ] && rm -ir "$target"
        [[ -L "$target" || -f "$target" ]] && rm "$target"
        
        ln -s "$item" ~/
        elif [ -d "$item" ]; then
        echo '~'"/.dotfiles/$name/ => $item"
        
        local target_dir="$HOME/.dotfiles"
        local target="$target_dir/$name"
        
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

echo-red() {
  echo -e "\e[31m$1\e[0m"
}

git_clone() {
  local name="${1#*/}"
  
  folder=$2
  if [ -z "$folder" ]; then
    folder=$name
  fi
  
  if [ -d "$name" ]; then
    echo-red "$name already downloaded"
  else
    echo-red "Downloading $name"
    git clone --depth 1 -q -- "https://github.com/$1" "$folder"
  fi
}

ARCH=$(uname -m)
if [ ! "$ARCH" = aarch64 ] && [ ! "$ARCH" = x86_64 ]; then
  echo-red "Unsupported platform"
  exit 1
fi

echo
echo " __  __                                 _"
echo "|  \/  | __ _ _ __   ___ _ __ ___ _ __ ( )___"
echo "| |\/| |/ _\` | '_ \ / _ \ '__/ _ \ '_ \|// __|"
echo "| |  | | (_| | | | |  __/ | |  __/ | | | \__ \\"
echo "|_|  |_|\__,_|_| |_|\___|_|  \___|_| |_| |___/"
echo
echo "     _       _    __ _ _"
echo "  __| | ___ | |_ / _(_) | ___  ___"
echo " / _\` |/ _ \| __| |_| | |/ _ \/ __|"
echo "| (_| | (_) | |_|  _| | |  __/\__ \\"
echo " \__,_|\___/ \__|_| |_|_|\___||___/"
echo
echo

mkdir -p ~/.local/bin ~/.local/shared ~/git-repos

packages_to_install=(asciinema bat fzf neovim yay python3 python-pip rustup zsh)

if [ "$ARCH" = aarch64 ]; then
  echo-red "Downloading powerline-go"
  curl 'https://github.com/justjanne/powerline-go/releases/download/latest/powerline-go-linux-arm64' -o ~/.local/bin/powerline-go
else
  packages_to_install+=(powerline-go)
fi

echo-red "Installing packages with pacman"
sudo pacman -Sy --needed --noconfirm "${packages_to_install[@]}"
echo-red "Installing fonts from AUR"
yay -S --noconfirm nerd-fonts-cascadia-code nerd-fonts-jetbrains-mono ttf-segoe-ui-variable

echo-red "Installing rust tooling"
rustup self upgrade-data
rustup install stable

echo-red "Installing lsd"
cargo install lsd

if ! which pnpm >/dev/null 2>&1; then
  echo-red "Downloading pnpm"
  curl -fsSL https://get.pnpm.io/install.sh | sh -
  
  export PNPM_HOME="$HOME/.local/share/pnpm"
  export PATH="$PNPM_HOME:$PATH"
else
  echo-red "pnpm already installed"
fi

(
  cd ~/ || exit 1
  echo-red "Installing NodeJS"
  pnpm config set store-dir ~/.cache/pnpm-store
  pnpm env use -g latest
)

if [ ! -d ~/.oh-my-zsh ]; then
  git_clone ohmyzsh/ohmyzsh ~/.oh-my-zsh
fi

(
  cd ~/.oh-my-zsh/custom/plugins || exit
  
  git_clone djui/alias-tips
  git_clone zsh-users/zsh-autosuggestions
  git_clone zsh-users/zsh-completions
  git_clone Maneren/zsh-interactive-cd
  git_clone zsh-users/zsh-syntax-highlighting
)

if [ -d /usr/share/X11/xkb/symbols ] && [ -f /usr/share/X11/xkb/rules/evdev.xml ]; then
  echo-red "Installing xkb layout - log out required"
  
  sudo ln -s ./keyboard/sexy_cz /usr/share/X11/xkb/symbols/
  
  layout_text="\
  <layout>
  <configItem>
  <name>sexy_cz</name>
  <shortDescription>Sexy Czech</shortDescription>
  <description>Czech (sexy, AltGr for acutes and carons)</description>
  <languageList>
  <iso639Id>cze</iso639Id>
  </languageList>
  </configItem>
  <variantList/>
  </layout>"
  
  modified=$(awk -v r="$layout_text\n</layoutList>" '{gsub(/<\/layoutList>/,r)}1' /usr/share/X11/xkb/rules/evdev.xml)
  echo "$modified" | sudo tee /usr/share/X11/xkb/rules/evdev.xml >/dev/null
  
  unset modified layout_text
fi

echo

copy_and_link_files

if [ ! "$(basename -- "$SHELL")" = zsh ]; then
  echo-red "Switching default shell to zsh"
  
  zsh="/bin/zsh"
  
  chsh -s $zsh
  export SHELL=$zsh
fi

exec zsh
