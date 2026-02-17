---
description: Complete issue from beads
---

1. **Select issue from provided list** (if issues were passed in prompt) or **Check ready work**: `bd list --ready --json`
2. **Claim your task**: `bd update <id> --status in_progress`
3. **Code style** Read @AGENTS.md for code style
4. **Implement**: Work ONLY on the selected task
5. **Discover new work?** Create linked issue:
   - `bd create "Found bug" --description="Details about what was found" -p 1 --deps discovered-from:<parent-id>`
   - Assign to model: add `-a agent-fast` (simple) or `-a agent-smart` (complex)
6. Run quality checks (e.g., typecheck, lint, test - use whatever your project requires)
7. Before marking work as done, call the @beads-reviewer sub-agent to check your work
8. Update AGENTS.md files if you discover reusable patterns
9. If checks pass, commit ALL changes with message: `[issue_type]: [Issue ID] - [Issue Title]`
10. **Complete**: `bd close <id> --reason "Done"`
