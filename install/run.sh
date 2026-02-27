#!/bin/bash

# -----------------------------------------------------------------------------
# Dotfiles Installation Script
# One command to set up a fresh macOS machine
#
# Usage: ./install/run.sh
# -----------------------------------------------------------------------------

print_logo() {
  cat << "EOF"

    ┌┬┐┌─┐┌┬┐┌─┐┬┬  ┌─┐┌─┐
     │││ │ │ ├┤ ││  ├┤ └─┐
    ─┴┘└─┘ ┴ └  ┴┴─┘└─┘└─┘
    macOS setup & config tool

EOF
}

# Resolve the directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

clear
print_logo

# Exit on any error
set -e

# Source utility functions
source "$SCRIPT_DIR/utils.sh"

# Source the package list
if [ ! -f "$SCRIPT_DIR/packages.conf" ]; then
  error "packages.conf not found!"
  exit 1
fi

source "$SCRIPT_DIR/packages.conf"

echo "Starting dotfiles setup..."
echo ""

# ─── Homebrew ────────────────────────────────────────────────────────────────

if ! command -v brew &>/dev/null; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add brew to PATH for this session (Apple Silicon)
  if [ -f "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  success "Homebrew already installed"
fi

info "Updating Homebrew..."
brew update

# ─── Packages ────────────────────────────────────────────────────────────────

echo ""
info "Installing CLI tools..."
install_formulas "${CLI_TOOLS[@]}"

echo ""
info "Installing development tools..."
install_formulas "${DEV_TOOLS[@]}"

echo ""
info "Installing fonts..."
install_casks "${FONTS[@]}"

echo ""
info "Installing applications..."
install_casks "${CASK_APPS[@]}"

# ─── Dotfiles (Stow) ────────────────────────────────────────────────────────

echo ""
info "Symlinking dotfiles with stow..."
source "$SCRIPT_DIR/stow-setup.sh"

# ─── Bootstrap ───────────────────────────────────────────────────────────────

echo ""
info "Bootstrapping tools and plugin managers..."
source "$SCRIPT_DIR/bootstrap.sh"

# ─── Done ────────────────────────────────────────────────────────────────────

echo ""
success "Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal (or run: source ~/.zshrc)"
echo "  2. Open tmux and press prefix + I to install tmux plugins"
echo "  3. Open nvim - lazy.nvim will auto-install plugins on first launch"
