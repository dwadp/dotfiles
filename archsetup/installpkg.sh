#!/usr/bin/env bash

set -euo pipefail

PACMAN_PKGS=(
  zsh
  neovim
  vim
  git
  lazygit
  bat
  ripgrep
  fzf
  fd
  git-delta
  atuin
  zoxide
  eza
  starship
  ghostty
  discord
  jq
  nmap
  openbsd-netcat
  websocat
  vlc
  vlc-plugins-base
  firefox
  obsidian
  bitwarden-bin
  docker
  docker-buildx
  docker-compose
  duf
  stow
  openbsd-netcat
  noto-fonts-cjk
  nmap
  ncdu
  btop
)

AUR_PKGS=(
  google-chrome
  microsoft-edge-stable-bin
  brave-bin
  visual-studio-code-bin
  openlens
  spotify
  gradia
  lens-bin
  beekeeper-studio
  balena-etcher
  galaxybudsclient-bin
)

# Optional: add more packages via env, e.g.
# PACMAN_EXTRAS="htop unzip" AUR_EXTRAS="docker-desktop" ./installpkg.sh
read -r -a PACMAN_EXTRAS <<< "${PACMAN_EXTRAS:-}"
read -r -a AUR_EXTRAS <<< "${AUR_EXTRAS:-}"

PACMAN_PKGS+=( "${PACMAN_EXTRAS[@]:-}" )
AUR_PKGS+=( "${AUR_EXTRAS[@]:-}" )

have() { command -v "$1" >/dev/null 2>&1; }
repo_has() { pacman -Si --quiet "$1" >/dev/null 2>&1; }
aur_has()  { yay -Si --quiet "$1" >/dev/null 2>&1; }

install_pacman() {
  local p="$1"
  if repo_has "$p"; then
    echo "==> pacman: $p"
    sudo pacman -S --noconfirm --needed "$p" || echo "!! pacman failed: $p"
  else
    echo "-- skip (not in repo): $p"
  fi
}

YAY_FLAGS=(
  --noconfirm
  --needed
  --answerclean All
  --answerdiff None
  --removemake
)

install_aur() {
  local p="$1"

  if ! have yay; then
    echo "!! yay not found. Install yay to get AUR packages. Skipping AUR."
    return 1
  fi

  if aur_has "$p" || ! repo_has "$p"; then
    echo "==>   yay: $p"
    yay -S "${YAY_FLAGS[@]}" "$p" || echo "!! yay failed: $p"
  else
    install_pacman "$p"
  fi
}

main() {
  echo "=== Syncing pacman database"
  sudo pacman -Syu --noconfirm

  echo
  echo "=== Installing official repo packages"
  for p in "${PACMAN_PKGS[@]}"; do
    install_pacman "$p"
  done

  echo
  echo "=== Installing AUR packages"
  if have yay; then
    for p in "${AUR_PKGS[@]}"; do
      install_aur "$p"
    done
  else
    echo "!! Skipping AUR list (yay not installed): ${AUR_PKGS[*]}"
  fi

  echo
  echo "All done. You can rerun this anytime after editing the lists."
}

main "$@"
