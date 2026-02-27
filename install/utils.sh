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
    else
      info "Installing cask: $cask"
      if ! brew install --cask "$cask" 2>/dev/null; then
        # App likely already exists in /Applications but wasn't installed via brew
        warn "$cask failed to install (app may already exist). Skipping."
      fi
    fi
  done
}
