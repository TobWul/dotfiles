#!/bin/bash

# -----------------------------------------------------------------------------
# Stow setup - symlink dotfiles to home directory
# -----------------------------------------------------------------------------

DOTFILES_DIR="$HOME/dotfiles"

# Packages to stow (active configs only)
STOW_PACKAGES=(
  bat
  ghostty
  gitconfig
  lazygit
  nvim
  opencode
  starship
  tmux
  zshrc
)

if ! command -v stow &>/dev/null; then
  echo "Error: stow is not installed. Run the package installation first."
  exit 1
fi

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Error: dotfiles directory not found at $DOTFILES_DIR"
  exit 1
fi

cd "$DOTFILES_DIR"

for package in "${STOW_PACKAGES[@]}"; do
  if [ -d "$package" ]; then
    echo "Stowing $package..."
    stow --restow "$package"
  else
    echo "Warning: package directory '$package' not found, skipping"
  fi
done

# Delta doesn't use stow - it's referenced via absolute path from .gitconfig
# Just verify the delta theme exists
if [ -f "$DOTFILES_DIR/delta/themes/catppuccin-theme.gitconfig" ]; then
  echo "Delta theme found at $DOTFILES_DIR/delta/themes/catppuccin-theme.gitconfig"
else
  echo "Warning: delta theme not found. Git diff colors may not work correctly."
fi
