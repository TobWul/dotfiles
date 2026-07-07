#!/bin/bash

# -----------------------------------------------------------------------------
# Utility functions for dotfiles installation
# -----------------------------------------------------------------------------

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info() {
  echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
  echo -e "${GREEN}[OK]${NC} $1"
}

warn() {
  echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

# Check if a brew formula is installed
is_formula_installed() {
  brew list --formula "$1" &>/dev/null
}

# Check if a brew cask is installed
is_cask_installed() {
  brew list --cask "$1" &>/dev/null
}

# Check if a cask's app bundle already exists in /Applications
# (e.g. installed manually or via the App Store, so brew doesn't know about it)
cask_app_exists() {
  local app
  while IFS= read -r app; do
    [ -e "/Applications/$app" ] && return 0
  done < <(brew info --cask "$1" 2>/dev/null |
    sed -n '/^==> Artifacts/,/^==> /p' | sed -n 's/ (App)$//p')
  return 1
}

# Install brew formulas (idempotent)
install_formulas() {
  local packages=("$@")
  local to_install=()

  for pkg in "${packages[@]}"; do
    if ! is_formula_installed "$pkg"; then
      to_install+=("$pkg")
    else
      success "$pkg already installed"
    fi
  done

  if [ ${#to_install[@]} -ne 0 ]; then
    info "Installing: ${to_install[*]}"
    brew install "${to_install[@]}"
  fi
}

# Install brew casks (idempotent, handles apps already in /Applications)
install_casks() {
  local casks=("$@")

  for cask in "${casks[@]}"; do
    if is_cask_installed "$cask"; then
      success "$cask already installed"
    elif cask_app_exists "$cask"; then
      success "$cask already in /Applications (not managed by brew)"
    else
      info "Installing cask: $cask"
      if ! brew install --cask "$cask" 2>/dev/null; then
        warn "$cask failed to install. Skipping."
      fi
    fi
  done
}
