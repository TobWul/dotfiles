# dotfiles

My dotfile configurations for macOS.

## Quick install

```zsh
./install/run.sh
```

This installs Homebrew, all packages, symlinks dotfiles with stow, and bootstraps tools.

## What gets installed

**CLI tools:** neovim, tmux, starship, lazygit, bat, ripgrep, fd, fzf, git-delta, zoxide, stow, jq, etc.

**Dev tools:** fnm

**Apps:** ghostty, raycast, 1password

**Fonts:** JetBrains Mono Nerd Font

## Stowed packages

bat, claude, ghostty, gitconfig, lazygit, nvim, opencode, starship, tmux, zshrc

## After install

1. Restart your terminal (or `source ~/.zshrc`)
2. Open tmux and press `prefix + I` to install plugins
3. Open nvim — lazy.nvim will auto-install plugins on first launch
