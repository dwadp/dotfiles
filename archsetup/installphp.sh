#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<EOF
Usage: $(basename "$0") [options]

Environment variables:
  PHP_VERSION=84             Install one PHP version (e.g. 82, 83, 84)
  PHP_VERSIONS="74 82 84"    Install multiple PHP versions
  SMTP_PROVIDER=postfix      Choose smtp-forwarder provider
                             (dma|exim|msmtp-mta|nullmailer|opensmtpd|postfix)
Examples:
  PHP_VERSION=84 ./install-php.sh
  PHP_VERSIONS="82 84" ./install-php.sh
  SMTP_PROVIDER=postfix PHP_VERSION=82 ./install-php.sh

If none are provided, defaults to PHP 84 and provider msmtp-mta.
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

PHP_VERSION="${PHP_VERSION:-}"
PHP_VERSIONS="${PHP_VERSIONS:-}"
SMTP_PROVIDER="${SMTP_PROVIDER:-msmtp-mta}"
DEFAULT_VERSION="84"

if ! command -v yay >/dev/null 2>&1; then
  echo "yay not found. Install yay first (e.g., via paru/pikaur or manually)."
  exit 1
fi

YAY_FLAGS=(
  --noconfirm
  --needed
  --answerclean All
  --answerdiff None
  --removemake
)

require() { command -v "$1" >/dev/null 2>&1 || { echo "Missing $1. Please install it first."; exit 1; }; }

install_provider() {
  echo ">> Installing SMTP provider: ${SMTP_PROVIDER}"
  yay -S "${YAY_FLAGS[@]}" "${SMTP_PROVIDER}"
}

install_php_version() {
  local version="$1"
  local pkgs=(
    "php${version}"
    "php${version}-cli"
    "php${version}-fpm"
    "php${version}-gd"
    "php${version}-imagick"
    "php${version}-pgsql"
    "php${version}-sodium"
    "php${version}-sqlite"
    "php${version}-xml"
    "php${version}-dom"
    "php${version}-simplexml"
    "php${version}-openssl"
    "php${version}-pdo"
    "php${version}-phar"
    "php${version}-pcntl"
    "php${version}-mysql"
    "php${version}-tokenizer"
    "php${version}-exif"
    "php${version}-bcmath"
    "php${version}-iconv"
    "php${version}-bz2"
    "php${version}-zip"
    "php${version}-fileinfo"
    "php${version}-ctype"
    "php${version}-mbstring"
    "php${version}-intl"
    "php${version}-calendar"
    "php${version}-gettext"
    "php${version}-curl"
    "php${version}-json"
    "php${version}-xmlwriter"
    "php${version}-xmlreader"
  )

  echo ">> Installing PHP ${v}: ${pkgs[*]}"
  yay -S "${YAY_FLAGS[@]}" "${pkgs[@]}"
}

main() {
  require yay

  local versions=()
  if [[ -n "$PHP_VERSIONS" ]]; then
    read -r -a versions <<<"$PHP_VERSIONS"
  elif [[ -n "$PHP_VERSION" ]]; then
    versions=("$PHP_VERSION")
  else
    versions=("$DEFAULT_VERSION")
  fi

  echo "Using versions: ${versions[*]}"
  echo "SMTP provider: ${SMTP_PROVIDER}"
  echo

  install_provider
  for v in "${versions[@]}"; do
    [[ "$v" =~ ^[0-9]{2}$ ]] || { echo "!! Skip invalid version '$v' (use 74/82/83/84 etc.)"; continue; }
    install_php_version "$v"
  done

  echo "Done."
}

main "$@"
