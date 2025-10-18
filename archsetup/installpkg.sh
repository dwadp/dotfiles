#!/usr/bin/env bash

set -euo pipefail

PACMAN_PKGS=(
  # Dependencies
  base-devel
  unzip
  ibus
  git
  zsh
  networkmanager-openvpn

  neovim
  vim
  tmux
  lazygit
  bat
  ripgrep
  fzf
  fd
  git-delta
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
  visual-studio-code-bin
  openlens
  spotify
  gradia
  lens-bin
  beekeeper-studio
  balena-etcher
  galaxybudsclient-bin
  microsoft-edge-stable-bin
  brave-bin
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

get_arch() {
  ARCH=$(uname -m)
  case $ARCH in
    armv5*) ARCH="armv5";;
    armv6*) ARCH="armv6";;
    armv7*) ARCH="arm";;
    aarch64) ARCH="arm64";;
    x86) ARCH="386";;
    x86_64) ARCH="amd64";;
    i686) ARCH="386";;
    i386) ARCH="386";;
  esac
  echo "$ARCH"
}

install_yay() {
  if have yay; then
    echo "yay already installed. Skipping!"
    return 0
  fi

  echo "!! yay not found. Installing it now!"
  sudo pacman -S --noconfirm --needed git base-devel
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay && makepkg -si
  rm -r /tmp/yay
  return 0
}

install_homebrew() {
  if have brew; then
    echo "brew already installed. Skipping!"
    return 0
  fi

  echo "Installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo
}

install_fnm() {
  if have fnm; then
    echo "fnm already installed. Skipping!"
    return 0
  fi

  echo "Installing fnm"
  curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
  echo
}

install_atuin() {
  if have atuin; then
    echo "atuin already installed. Skipping!"
    return 0
  fi

  echo "Installing atuin"
  bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)
  echo
}

install_go() {
  if have go; then
    echo "Go already installed. Skipping!"
    return 0
  fi

  local arch=$(get_arch);

  local go_latest_version="$(curl -fsSL 'https://go.dev/dl/?mode=json&include=all' \
    | jq -rc 'first(.[] | select(.stable == true)) | .version')"
  echo "Installing latest stable Go version: $go_latest_version"

  local file="${go_latest_version}.linux-${go_arch}.tar.gz";
  sha="$(curl -fsSL 'https://go.dev/dl/?mode=json&include=all' \
    | jq -r --arg v "${go_latest_version}" --arg f "$file" \
        '.[] | select(.version==$v) | .files[] | select(.filename==$f and .os=="linux" and .arch!=null and .kind=="archive") | .sha256')";
[ -n "$sha" ] || { echo "Could not find SHA256 for $file"; exit 1; };

  curl -fsSL "https://go.dev/dl/${file}" -o /tmp/go.tgz;
  echo "${sha}  /tmp/go.tgz" | sha256sum -c -;
  sudo rm -rf /usr/local/go;
  sudo tar -C /usr/local -xzf /tmp/go.tgz;
  rm /tmp/go.tgz;

  echo "Finished installing Go version: $go_latest_version"
  echo
}

install_tmux_tpm() {
  if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "Installing & setup TMUX Tpm plugin"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    tmux source ~/.tmux.conf
  else
    echo "TMUX Tpm plugin already installed. Skipping!"
  fi

  echo
}

install_kubectl_helm() {
  if ! have kubectl; then
    local stable_version="$(curl -fsSL https://dl.k8s.io/release/stable.txt)"

    echo "Installing kubectl stable version: $stable_version"
    curl -fsSLo /tmp/kubectl "https://dl.k8s.io/release/$stable_version/bin/linux/amd64/kubectl"
    chmod +x /tmp/kubectl
    sudo mv /tmp/kubectl /usr/local/bin/kubectl

    echo "Finished installing kubectl stable version: $stable_version"
  else
    echo "kubectl already installed. Skipping!"
  fi

  if ! have helm; then
    echo "Installing helm"
    curl -fsSL -o /tmp/get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 /tmp/get_helm.sh
    bash /tmp/get_helm.sh
    rm /tmp/get_helm.sh
  else
    echo "helm already installed. Skipping!"
  fi
}

install_aws_cli() {
  if ! have aws; then
    echo "Installing aws cli"
    curl -fsSLo "/tmp/awscliv2.zip" "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
    cd /tmp
    unzip awscliv2.zip
    sudo ./aws/install
    rm -r ./aws
    rm -f awscliv2.zip
  else
    echo "aws cli already installed. Skipping!"
  fi
}

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

  install_yay

  for p in "${AUR_PKGS[@]}"; do
    install_aur "$p"
  done

  install_go
  install_homebrew
  install_fnm
  install_atuin
  install_tmux_tpm
  install_kubectl_helm
  install_aws_cli

  echo
  echo "All done. You can rerun this anytime after editing the lists."
}

main "$@"
