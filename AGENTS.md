# AGENTS.md

## Repository Overview

This is a macOS dotfiles repository managed with **GNU Stow**. Each top-level directory is a stow package that mirrors the home directory structure. The repo lives at `~/dotfiles`.

## Structure

```
dotfiles/
├── install/           # Installation scripts (run.sh is the entry point)
├── agents/            # Shared agent skills (~/.agents/skills) for Claude Code, OpenCode, Codex
├── bat/               # bat (cat replacement) config + catppuccin theme
├── delta/             # git-delta theme (NOT stowed - referenced by absolute path)
├── ghostty/           # Ghostty terminal config
├── gitconfig/         # Global git config (.gitconfig)
├── herdr/             # herdr workspace manager config + herdr-sessionizer script
├── lazygit/           # Lazygit TUI config
├── nvim/              # Neovim config (lazy.nvim, kickstart-based)
├── opencode/          # OpenCode AI assistant config + agent prompts
├── starship/          # Starship prompt config
├── worktrunk/         # Worktrunk worktree manager config
├── zshrc/             # Zsh config (zinit, pure prompt, aliases, tools)
├── alacritty/         # (inactive) Alacritty terminal config
├── ipython/           # (inactive) IPython config
├── kitty/             # (inactive) Kitty terminal config
└── mcphub/            # (inactive) MCP Hub servers config
```

## Active Stow Packages

These 12 packages are actively used and deployed via `stow --restow <package>`:

`agents`, `bat`, `claude`, `ghostty`, `gitconfig`, `herdr`, `lazygit`, `nvim`, `opencode`, `starship`, `worktrunk`, `zshrc`

The `delta/` directory is an exception -- it is referenced via absolute path (`~/dotfiles/delta/themes/catppuccin-theme.gitconfig`) from `.gitconfig` and does not need stowing.

## Installation Scripts

All install automation lives in `install/`. The pattern follows the typecraft Crucible approach -- modular bash scripts with a single entry point.

| File                    | Purpose                                                                                             |
| ----------------------- | --------------------------------------------------------------------------------------------------- |
| `install/run.sh`        | Main orchestrator. Installs Homebrew, packages, stows dotfiles, bootstraps tools.                   |
| `install/utils.sh`      | Helper functions: colored output, idempotent `install_formulas()` and `install_casks()`.            |
| `install/packages.conf` | Categorized package arrays: `CLI_TOOLS`, `DEV_TOOLS`, `CASK_APPS`, `FONTS`.                         |
| `install/stow-setup.sh` | Runs `stow --restow` for each active package.                                                       |
| `install/bootstrap.sh`  | Post-install setup: Node.js via fnm, ni, Bun, bat cache, OpenCode CLI, Worktrunk shell integration. |

Run everything with: `./install/run.sh`

## Key Conventions

- **Package manager**: Homebrew (formulas for CLI tools, casks for GUI apps and fonts)
- **Symlink manager**: GNU Stow (run from `~/dotfiles`, targets `$HOME`)
- **Shell**: Zsh with Zinit plugin manager (auto-bootstraps on first launch)
- **Editor**: Neovim with lazy.nvim (auto-installs plugins on first launch)
- **Terminal**: Ghostty
- **Theme**: Catppuccin Mocha everywhere (terminal, nvim, bat, delta, lazygit, herdr)
- **Node.js**: Managed via fnm (aliased as `nvm` in .zshrc)
- **Git**: SSH signing enabled, delta as pager, commit signing on
- **Worktrees**: Managed via Worktrunk (`wt`) with lifecycle hooks. Worktrees live in `~/worktrees/<repo>/<branch>`.

## Git Worktree Workflow

Repos are normal clones in `~/git/<repo>` (the primary worktree, copy source for `.env` and other ignored files). Extra worktrees are managed by [Worktrunk](https://worktrunk.dev) (`wt`) and live in `~/worktrees/<repo>/<branch>`.

The user config is `worktrunk/.config/worktrunk/config.toml`:

- **worktree-path**: `~/worktrees/{{ repo }}/{{ branch | sanitize }}`
- **commit.generation**: LLM commit messages via Claude Code (`claude -p --model=haiku`)
- **post-start**: `wt step copy-ignored` copies ignored files from the primary worktree

Shell integration (so `wt switch` can `cd`) is the `eval "$(wt config shell init zsh)"` line in `.zshrc`. Per-project hooks (dep install, dev servers) go in each repo's `.config/wt.toml`.

## Agent Skills

All agent skills live in one store: `agents/.agents/skills/` (stowed to `~/.agents/skills`). Skill files and the global lock (`agents/.agents/.skill-lock.json`) are committed, so a fresh machine gets them from stow alone.

- **Install/update** with the `skills` zsh function (wraps `npx skills@latest` from [vercel-labs/skills](https://github.com/vercel-labs/skills)). It forces global mode and targets only `codex`, whose global path is `~/.agents/skills`: `skills add mattpocock/skills -s tdd`, `skills update`, `skills rm <name>`, `skills ls`.
- **Other agents** get a whole-dir symlink to `~/.agents/skills`, created by the `AGENT_SKILL_DIRS` loop in `install/stow-setup.sh` (`~/.claude/skills`, `~/.config/opencode/skills`). To support a new agent, add its global skills dir there. Never let the CLI target `claude-code`/`opencode` directly -- it would write per-skill symlinks into stowed dirs.
- Don't use Claude Code plugins for skills that exist here (avoids duplicates).
- `synced/` and `.trash/` inside the skills dir are Claude Code runtime state and are gitignored.
- `use-railway` is hand-managed (not in the lock).
- `ren-ui-design` is work-specific and gitignored: it lives only on this machine and is never published.

## Editing Guidelines

- When adding a new tool config, create a new top-level stow package directory mirroring `$HOME` paths (e.g., `toolname/.config/toolname/config`).
- Add the package name to `STOW_PACKAGES` in `install/stow-setup.sh`.
- Add any brew dependencies to the appropriate array in `install/packages.conf`.
- All scripts must be idempotent -- safe to run multiple times without side effects.
- This repo is public. Never commit secrets (API keys, tokens, private keys, passwords) or private/work details (internal hostnames, work emails, customer names). Use placeholders or read values from env vars or 1Password at runtime.
