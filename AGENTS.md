# AGENTS.md

## Repository Overview

This is a macOS dotfiles repository managed with **GNU Stow**. Each top-level directory is a stow package that mirrors the home directory structure. The repo lives at `~/dotfiles`.

## Structure

```
dotfiles/
├── install/           # Installation scripts (run.sh is the entry point)
├── bat/               # bat (cat replacement) config + catppuccin theme
├── delta/             # git-delta theme (NOT stowed - referenced by absolute path)
├── ghostty/           # Ghostty terminal config
├── gitconfig/         # Global git config (.gitconfig)
├── lazygit/           # Lazygit TUI config
├── nvim/              # Neovim config (lazy.nvim, kickstart-based)
├── opencode/          # OpenCode AI assistant config + agent prompts
├── starship/          # Starship prompt config
├── tmux/              # tmux config + catppuccin theme + tmux-sessionizer script
├── worktrunk/         # Worktrunk worktree manager config + wt-tmux-session helper
├── zshrc/             # Zsh config (zinit, pure prompt, aliases, tools)
├── alacritty/         # (inactive) Alacritty terminal config
├── ipython/           # (inactive) IPython config
├── kitty/             # (inactive) Kitty terminal config
└── mcphub/            # (inactive) MCP Hub servers config
```

## Active Stow Packages

These 10 packages are actively used and deployed via `stow --restow <package>`:

`bat`, `ghostty`, `gitconfig`, `lazygit`, `nvim`, `opencode`, `starship`, `tmux`, `worktrunk`, `zshrc`

The `delta/` directory is an exception -- it is referenced via absolute path (`~/dotfiles/delta/themes/catppuccin-theme.gitconfig`) from `.gitconfig` and does not need stowing.

## Installation Scripts

All install automation lives in `install/`. The pattern follows the typecraft Crucible approach -- modular bash scripts with a single entry point.

| File | Purpose |
|---|---|
| `install/run.sh` | Main orchestrator. Installs Homebrew, packages, stows dotfiles, bootstraps tools. |
| `install/utils.sh` | Helper functions: colored output, idempotent `install_formulas()` and `install_casks()`. |
| `install/packages.conf` | Categorized package arrays: `CLI_TOOLS`, `DEV_TOOLS`, `CASK_APPS`, `FONTS`. |
| `install/stow-setup.sh` | Runs `stow --restow` for each active package. |
| `install/bootstrap.sh` | Post-install setup: TPM, Node.js via fnm, ni, Bun, bat cache, OpenCode CLI, Worktrunk shell integration. |

Run everything with: `./install/run.sh`

## Key Conventions

- **Package manager**: Homebrew (formulas for CLI tools, casks for GUI apps and fonts)
- **Symlink manager**: GNU Stow (run from `~/dotfiles`, targets `$HOME`)
- **Shell**: Zsh with Zinit plugin manager (auto-bootstraps on first launch)
- **Editor**: Neovim with lazy.nvim (auto-installs plugins on first launch)
- **Terminal**: Ghostty
- **Theme**: Catppuccin Mocha everywhere (terminal, nvim, bat, delta, lazygit, tmux)
- **Node.js**: Managed via fnm (aliased as `nvm` in .zshrc)
- **Git**: SSH signing enabled, delta as pager, commit signing on
- **Worktrees**: Managed via Worktrunk (`wt`) with lifecycle hooks. Repos are cloned bare into `~/git/repo.git`, worktrees live inside the bare repo directory.

## Git Worktree Workflow

Repos are cloned as **bare repos** (`git clone --bare`) into `~/git/repo.git`. All code lives in worktrees inside the bare repo directory. The `main` worktree must be created first as the "primary" (copy source for `.env`, ignored files, etc.).

Worktrees are managed by [Worktrunk](https://worktrunk.dev) (`wt` command). The user config lives in `worktrunk/.config/worktrunk/config.toml` and defines:

- **Worktree path**: Relative to the bare repo (configurable via `worktree-path` template)
- **LLM commit messages**: via OpenCode (claude-haiku-4.5)
- **post-start hook**: Copies ignored files from primary worktree (graceful failure if none exists)
- **post-create hook**: Launches a tmux session (Code/AI/Server layout) via `wt-tmux-session`
- **post-switch hook**: Renames tmux window to branch name

Per-project hooks (dep install, env symlinks, dev servers) go in each repo's `.config/wt.toml`.

The `tmux-sessionizer` script (Ctrl-f) handles `~/git` non-bare project selection only (skips `*.git` dirs). Worktree navigation uses `wt switch` (interactive picker with diff/log previews).

## Editing Guidelines

- When adding a new tool config, create a new top-level stow package directory mirroring `$HOME` paths (e.g., `toolname/.config/toolname/config`).
- Add the package name to `STOW_PACKAGES` in `install/stow-setup.sh`.
- Add any brew dependencies to the appropriate array in `install/packages.conf`.
- All scripts must be idempotent -- safe to run multiple times without side effects.
