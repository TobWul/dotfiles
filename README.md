# dotfiles

macOS development environment managed with GNU Stow. One command to set up a fresh machine, worktree-based git workflow for running parallel AI agents.

## Quick Start

```bash
# Clone to ~/dotfiles (required location for stow)
git clone git@github.com:<user>/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install everything: Homebrew, packages, symlinks, tools
./install/run.sh

# Restart your terminal, then open nvim — lazy.nvim auto-installs plugins on first launch
```

## What's Included

| Package | What it configures |
|---|---|
| `bat` | bat (cat replacement) with Catppuccin theme |
| `delta` | git-delta diff theme (referenced by path, not stowed) |
| `ghostty` | Ghostty terminal |
| `gitconfig` | Global git config (SSH signing, delta pager) |
| `herdr` | herdr workspace manager config + herdr-sessionizer project picker |
| `lazygit` | Lazygit TUI |
| `nvim` | Neovim (lazy.nvim, kickstart-based) |
| `opencode` | OpenCode AI config, agents, commands, helper scripts |
| `starship` | Starship prompt |
| `worktrunk` | Worktrunk worktree manager config |
| `zshrc` | Zsh config (Zinit, pure prompt, aliases, tools) |

Theme is **Catppuccin Mocha** everywhere.

## Git Workflow

Projects are normal clones in `~/git/<repo>`. That checkout is the **primary** worktree: the copy source for `.env` files and other ignored artifacts. Extra worktrees for parallel work are managed by [Worktrunk](https://worktrunk.dev) (`wt`) and live in `~/worktrees/<repo>/<branch>`.

### Day-to-day: herdr project picker

Press `Ctrl-f` in the shell (or `prefix+n` in herdr) to open the project picker. It lists the projects in `~/git` and every worktree in `~/worktrees` (labelled `repo/branch`), and opens the pick in a new herdr workspace. `prefix+f` switches between workspaces that are already open.

### Worktrees with Worktrunk

#### Create a worktree

```bash
cd ~/git/repo

# New branch from the default branch
wt switch --create feature-auth

# From a specific base
wt switch --create hotfix --base production

# Existing remote branch
wt switch feature-auth
```

This creates `~/worktrees/repo/feature-auth`, copies ignored files from the primary worktree, runs any project hooks and `cd`s into it.

#### Launch an AI agent in a worktree

```bash
wt switch --create feature-auth -x claude
wt switch --create fix-bug -x claude -- 'Fix the pagination bug in GH #322'
```

#### List worktrees

```bash
wt list
```

Shows all worktrees with branch status, commit info, and CI status.

#### Interactive picker

```bash
wt switch
```

Without arguments, opens an interactive picker with live diff and log previews.

#### Merge and clean up

```bash
# From inside a feature worktree:

# Option A: Merge locally (squash + rebase + merge + cleanup)
wt merge

# Option B: PR workflow (push, open PR, merge on GitHub, then cleanup)
wt step commit          # LLM-generated commit message
git push -u origin HEAD
gh pr create
# ... after PR is merged on GitHub ...
wt remove
```

#### Switch between worktrees

```bash
wt switch feature-auth      # By branch name
wt switch -                  # Previous worktree (like cd -)
wt switch ^                  # Back to main/default branch
wt switch pr:123             # Jump to a GitHub PR's branch
```

#### Remove a worktree

```bash
wt remove           # Remove current worktree
wt remove feature   # Remove specific worktree
```

### Per-project hooks

Add a `.config/wt.toml` to each repo for project-specific automation. These run automatically when creating worktrees.

**Example: Node.js project**

```toml
# .config/wt.toml
[post-create]
env = "ln -sf {{ primary_worktree_path }}/.env {{ worktree_path }}/.env"
install = "npm ci"

[post-start]
copy = "wt step copy-ignored"
server = "npm run dev -- --port {{ branch | hash_port }}"

[pre-merge]
test = "npm test"
build = "npm run build"

[post-remove]
server = "lsof -ti :{{ branch | hash_port }} -sTCP:LISTEN | xargs kill 2>/dev/null || true"
```

**Example: Monorepo with subdirectory (like netlin4/weblin)**

```toml
# .config/wt.toml
[post-create]
env = "ln -sf {{ primary_worktree_path }}/weblin/.env {{ worktree_path }}/weblin/.env"
install = "cd weblin && bun install"
```

The first time project hooks run, Worktrunk asks for approval.

## OpenCode Agents

The `opencode/` package includes several AI agent configurations:

| Agent | Purpose |
|---|---|
| `orchestrator` | Coordinates @worker sub-agents for Linear issues |
| `worker` | Executes single Linear issues (TDD workflow) |
| `prd` | Brainstorms ideas into Linear PRD plans |
| `reviewer` | Reviews work for spec compliance + code quality |

Commands: `worker-loop`, `land`, `ux-microcopy`

Helper scripts:
- `ralph` — Runs the worker loop against Linear issues (`ralph --issue ENG-123`)

## Shell Aliases

| Alias | Command |
|---|---|
| `vim` | `nvim` |
| `lg` | `lazygit` |
| `ai` | `opencode` |
| `Ctrl-f` | `herdr-sessionizer` (project picker) |

## Adding a New Tool

1. Create a stow package directory: `toolname/.config/toolname/config`
2. Add the package to `STOW_PACKAGES` in `install/stow-setup.sh`
3. Add brew dependencies to `install/packages.conf`
4. Run `stow --restow toolname` from `~/dotfiles`

All scripts are idempotent — safe to run multiple times.
