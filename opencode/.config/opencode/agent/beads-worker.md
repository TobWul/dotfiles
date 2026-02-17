---
description: Complete tasks from beads
mode: primary
tools:
  write: true
  edit: true
  bash: true
  figma: true
  linear: false
permissions:
  bash:
    "git diff": allow
    "git log*": allow
    "git add*": allow
    "git commit*": allow
    "npm install": "allow"
    "npm install *": "ask"
---

# Project Instructions for AI Agents

This file provides instructions and context for AI coding agents working on this project.

## Issue Tracking with bd (beads)

**IMPORTANT**: This project uses **bd (beads)** for ALL issue tracking. Do NOT use markdown TODOs, task lists, or other tracking methods.

### Why bd?

- Dependency-aware: Track blockers and relationships between issues
- Git-friendly: Auto-syncs to JSONL for version control
- Agent-optimized: JSON output, ready work detection, discovered-from links
- Prevents duplicate tracking systems and confusion

### Quick Start

**Check for ready work:**

```bash
bd list --ready --json
```

**Create new issues:**

```bash
bd create "Issue title" --description="Detailed context" -t bug|feature|task -p 0-4 --json
bd create "Issue title" --description="What this issue is about" -p 1 --deps discovered-from:bd-123 --json

# Assign to specific model type
bd create "Simple refactor" --description="Rename function" -t task -p 3 -a agent-fast --json
bd create "Design auth strategy" --description="Complex architecture decision" -t feature -p 1 -a agent-smart --json
```

**Claim and update:**

```bash
bd update bd-42 --status in_progress --json
bd update bd-42 --priority 1 --json
```

**Review before completing:**

Before marking work as done, call the @beads-reviewer sub-agent to check your work

**Complete work:**

```bash
bd close bd-42 --reason "Completed" --json
```

### Issue Types

- `bug` - Something broken
- `feature` - New functionality
- `task` - Work item (tests, docs, refactoring)
- `epic` - Large feature with subtasks
- `chore` - Maintenance (dependencies, tooling)

### Priorities

- `0` - Critical (security, data loss, broken builds)
- `1` - High (major features, important bugs)
- `2` - Medium (default, nice-to-have)
- `3` - Low (polish, optimization)
- `4` - Backlog (future ideas)

### Model Assignment

Use `--assignee` (`-a`) to route issues to appropriate models:

- `agent-fast` - Simple, mechanical tasks (refactoring, formatting, docs, boilerplate)
- `agent-smart` - Complex, reasoning-heavy tasks (architecture, debugging, security)

**Filtering ready work by model:**

```bash
bd list --assignee agent-fast --ready --json   # Fast agent's work
bd list --assignee agent-smart --ready --json  # Smart agent's work
```

### Auto-Sync

bd automatically syncs with git:

- Exports to `.beads/issues.jsonl` after changes (5s debounce)
- Imports from JSONL when newer (e.g., after `git pull`)
- No manual export/import needed!

### Workflow for Completing Work

1. **Check ready work**: `bd list --ready --json` shows unblocked issues
2. **Claim your task**: `bd update <id> --status in_progress --json`
3. **Work on it**: Implement, test, document
4. **Discover new work?** Create linked issue:
   - `bd create "Found bug" --description="Details" -p 1 --deps discovered-from:<parent-id> --json`
5. **Review**: Call the beads-reviewer sub-agent before completing
6. **Fix feedback**: Address any P0/P1 issues from review
7. **Complete**: `bd close <id> --reason "Done" --json`

### Important Rules

- ✅ Use bd for ALL task tracking
- ✅ Always use `--json` flag for programmatic use
- ✅ Link discovered work with `discovered-from` dependencies
- ✅ Check `bd ready` before asking "what should I work on?"
- ❌ Do NOT create markdown TODO lists
- ❌ Do NOT use external issue trackers
- ❌ Do NOT duplicate tracking systems

For more details, see README.md and docs/QUICKSTART.md.

## Build & Test

```bash
# Example:
npm install
npm lint
npm typecheck
npm test
```
