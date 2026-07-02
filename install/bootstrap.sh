#!/bin/bash

# -----------------------------------------------------------------------------
# Bootstrap - install plugin managers and runtime tools
# -----------------------------------------------------------------------------

# TPM (Tmux Plugin Manager)
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ -d "$TPM_DIR" ]; then
  echo "TPM already installed"
else
  echo "Installing Tmux Plugin Manager (TPM)..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
  echo "TPM installed. Start tmux and press prefix + I to install plugins."
fi

# Zinit (Zsh plugin manager) - auto-bootstraps from .zshrc on first load
# Just verify the target directory is ready
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ -d "$ZINIT_HOME" ]; then
  echo "Zinit already installed"
else
  echo "Zinit will auto-install on first zsh launch (configured in .zshrc)"
fi

# fnm - install latest LTS Node.js if fnm is available
if command -v fnm &>/dev/null; then
  echo "Setting up Node.js via fnm..."
  eval "$(fnm env)"
  if fnm list | grep -q "lts"; then
    echo "Node.js LTS already installed"
  else
    fnm install --lts
    echo "Node.js LTS installed via fnm"
  fi
else
  echo "Warning: fnm not found. Install packages first."
fi

# ni (universal package manager installer by antfu)
if command -v ni &>/dev/null; then
  echo "ni already installed"
else
  if command -v npm &>/dev/null; then
    echo "Installing ni (@antfu/ni)..."
    npm install -g @antfu/ni
    echo "ni installed"
  else
    echo "Warning: npm not found. Skipping ni installation."
  fi
fi

# Bun
if command -v bun &>/dev/null; then
  echo "Bun already installed"
else
  echo "Installing Bun..."
  curl -fsSL https://bun.com/install | bash
  echo "Bun installed"
fi

# Bat theme cache - rebuild to pick up catppuccin theme
if command -v bat &>/dev/null; then
  echo "Rebuilding bat theme cache..."
  bat cache --build
  echo "Bat theme cache rebuilt"
else
  echo "Warning: bat not found. Install packages first."
fi

# OpenCode CLI
OPENCODE_BIN="$HOME/.opencode/bin/opencode"
if [ -f "$OPENCODE_BIN" ]; then
  echo "OpenCode already installed"
else
  echo "Installing OpenCode..."
  curl -fsSL https://opencode.ai/install | bash
  echo "OpenCode installed"
fi

# Worktrunk (git worktree manager) - shell integration + executable permissions
if command -v wt &>/dev/null; then
  echo "Worktrunk already installed"
  # Ensure wt-tmux-session helper is executable
  WTS="$HOME/.local/bin/wt-tmux-session"
  [ -f "$WTS" ] && chmod +x "$WTS"
  # Shell integration is sourced from .zshrc via eval
else
  echo "Warning: worktrunk not found. Install packages first."
fi
