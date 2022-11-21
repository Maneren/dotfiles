#!/usr/bin/env bash

echo
echo " __  __                                 _"
echo "|  \/  | __ _ _ __   ___ _ __ ___ _ __  | |___"
echo "| |\/| |/ _\` | '_ \ / _ \ '__/ _ \ '_ \ |// __|"
echo "| |  | | (_| | | | |  __/ | |  __/ | | |  \__ \\"
echo "|_|  |_|\__,_|_| |_|\___|_|  \___|_| |_|  |___/"
echo
echo "     _       _    __ _ _"
echo "  __| | ___ | |_ / _(_) | ___  ___"
echo " / _\` |/ _ \| __| |_| | |/ _ \/ __|"
echo "| (_| | (_) | |_|  _| | |  __/\__ \\"
echo " \__,_|\___/ \__|_| |_|_|\___||___/"
echo
echo

set -e

pm() {
  sudo pacman -S --needed --noconfirm "$@"
}

ya() {
  yay -S --needed --noconfirm "$@"
}

echo-red() {
  echo -e "\e[31m$1\e[0m"
}

git_clone() {
  local name="${1##*/}"
  
  folder=$2
  if [ -z "$folder" ]; then
    folder=$name
  fi
  
  if [ -d "$folder" ]; then
    echo-red "$name already downloaded"
    git -C "$folder" pull
  else
    echo-red "Downloading $name"
    git clone --depth 1 -q -- "https://github.com/$1" "$folder"
  fi
}

update() {
  echo-red "Updating system..."
  sudo pacman -Syyuu --noconfirm
}

packages() {
  echo-red "Installing packages..."
  pm asciinema bat bpytop curl diff-so-fancy fd git jq lsd make nano neovim p7zip python3 python-pip wget yay
  install_zinit
  install_node
  install_rustup
  install_tmux
  
  [ "$(uname -m)" = aarch64 ] && packages_arm
  [ "$(uname -m)" = x86_64 ] && packages_x86
}

packages_x86() {
  echo-red "Installing x86 packages..."

  pm powerline-go

  home_packages
  install_fonts
  keyboard
}

packages_arm() {
  echo-red "Installing arm packages..."

  ya powerline-go-git
}

install_tmux () {
  echo-red "Installing tmux..."
  pm tmux
  git_clone tmux-plugins/tpm ~/.tmux/plugins/tpm
}

home_packages() {
  echo-red "Installing home packages..."
  pm libreoffice onlyoffice-desktopeditors discord steam-manjaro peek bitwarden thunderbird flameshot
  install_replugged
}

install_replugged () {
  echo-red "Installing Replugged..."
  (
    cd ~/git-repos || exit 1
    git_clone replugged-org/replugged
    cd replugged || exit 1
    pnpm i
    sudo pnpm plug
  )
}

install_node() {
  echo-red "Installing NodeJS and pnpm..."
  pm nodejs

  sudo corepack enable

  local pnpm_version
  pnpm_version=$(curl -sL https://api.github.com/repos/pnpm/pnpm/releases/latest | jq -r ".tag_name")

  sudo corepack prepare "pnpm@$pnpm_version" --activate

  (
    cd ~/ || exit 1
    pnpm config set store-dir ~/.cache/pnpm-store
  )
}

install_rustup() {
  echo-red "Installing rustup..."
  pm rustup
  rustup self upgrade-data
  rustup toolchain install stable
  rustup toolchain install nightly
  rustup default stable
}

install_fonts() {
  echo-red "Installing fonts..."
  ya ttf-twemoji ttf-segoe-ui-variable nerd-fonts-cascadia-code nerd-fonts-jetbrains-mono
  sudo ln -sf /usr/share/fontconfig/conf.avail/75-twemoji.conf /etc/fonts/conf.d/75-twemoji.conf
  
  (
    ya ttfautohint

    local target="$HOME/git-repos/Iosevka"
    
    git_clone be5invis/Iosevka "$target"
    
    ln -sf "$(pwd)/fonts/Iosevka/private-build-plans.toml" "$target"
    
    cd "$target"  || exit 1
    
    pnpm i && pnpm build -- ttf::iosevka-custom
    
    sudo mkdir -p /usr/local/share/fonts
    sudo mkdir -p /usr/local/share/fonts/iosevka-custom/
    
    sudo cp dist/* /usr/local/share/fonts/iosevka-custom/
  )
}

install_zinit() { # Installs zsh, oh-my-zsh and plugins
  echo-red "Installing zsh and zinit..."
  pm zsh

  mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
  git_clone zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git"
}

dotfiles() {
  echo-red "Installing dotfiles..."
  mkdir -p ~/.dotfiles

  local base
  base="$(pwd)"

  local dirs
  dirs=(bash git zsh tmux) # folders to be linked

  for dir in "${dirs[@]}"; do
    echo-red "Setting up $(basename "$dir")"

    local items
    items=$(find "$dir" -maxdepth 1 -mindepth 1)

    for item in $items; do
      name="$(basename "$item")"

      item="$base/$item"

      if [ -f "$item" ]; then
        local target="$HOME/$name"

        # if already correctly linked continue
        [ "$target" -ef "$item" ] && continue

        echo '~'"/$name => $item"

        # if there is something else, prompt user to delete it
        [ -d "$target" ] && rm -ir "$target"
        [[ -L "$target" || -f "$target" ]] && rm "$target"

        ln -s "$item" ~/
      elif [ -d "$item" ]; then

        local target="$HOME/.dotfiles/$name"

        # if already correctly linked continue
        [ "$target" -ef "$item" ] && continue

        echo '~'"/.dotfiles/$name/ => $item"

        # if there is something else, prompt user to delete it
        [ -d "$target" ] && rm -ri "$target"
        [[ -L "$target" || -f "$target" ]] && rm -i "$target"

        ln -s "$item" "$target"
      fi
    done

    printf "\n"
  done
}

init() {
  echo-red "Initializing..."
  mkdir -p ~/.local/bin ~/.local/shared ~/git-repos
}

keyboard() {
  echo-red "Installing keyboard layout..."
  if
    [ -d /usr/share/X11/xkb/symbols ] &&
      [ -f /usr/share/X11/xkb/rules/evdev.xml ] &&
      [ ! -e /usr/share/X11/xkb/symbols/sexy_cz ]
  then
    echo-red "Installing xkb layout - log out required"

    sudo ln -sf "$(pwd)/keyboard/sx" /usr/share/X11/xkb/symbols/

    local layout_text="
    <layout>
    <configItem>
    <name>sx</name>
    <shortDescription>Sexy Czech</shortDescription>
    <description>Czech (sexy, AltGr for acutes and carons)</description>
    <languageList>
    <iso639Id>cze</iso639Id>
    </languageList>
    </configItem>
    <variantList/>
    </layout>"

    local modified
    modified=$(awk -v r="$layout_text\n</layoutList>" '{gsub(/<\/layoutList>/,r)}1' /usr/share/X11/xkb/rules/evdev.xml)
    echo "$modified" | sudo tee /usr/share/X11/xkb/rules/evdev.xml >/dev/null
  else
    echo-red "No xkb config found"
  fi
}

change_shell() {
  if [ ! "$(basename -- "$SHELL")" = zsh ]; then
    echo-red "Switching default shell to zsh"

    (
      zsh="/bin/zsh"
      export SHELL=$zsh
      sudo chsh -s $zsh "$USER"
    )
  fi
}

update
init
packages
dotfiles
change_shell

exec /bin/zsh
