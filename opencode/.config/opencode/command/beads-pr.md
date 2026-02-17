---
description: Work on beads issue in PR
---

1. **Select issue from provided list** (if issues were passed in prompt) or **Check ready work**: `bd list --ready --json`
2. **Claim your task**: `bd update <id> --status in_progress`
3. **Create or checkout branch**: Use epic issue ID if it exists, otherwise use the issue ID
   - Check if issue belongs to an epic: `bd show <id>` (look for parent/epic in dependencies)
   - If epic exists: `git checkout -b <epic-id>` or `git checkout <epic-id>` if branch exists
   - If no epic: `git checkout -b <issue-id>`
4. **Code style** Read @AGENTS.md for code style
5. **Implement**: Work ONLY on the selected task
6. **Discover new work?** Create linked issue:
   - `bd create "Found bug" --description="Details about what was found" -p 1 --deps discovered-from:<parent-id>`
   - Assign to model: add `-a agent-fast` (simple) or `-a agent-smart` (complex)
7. Run quality checks (e.g., typecheck, lint, test - use whatever your project requires)
8. Before marking work as done, call the @beads-reviewer sub-agent to check your work
9. Update AGENTS.md files if you discover reusable patterns
10. If checks pass, commit ALL changes with message: `[issue_type]: [Issue ID] - [Issue Title]`
11. **Push and create PR**:
    - `git push -u origin <branch-name>`
    - `gh pr create --title "[issue_type]: [Issue ID] - [Issue Title]" --body "Closes <issue-id>"`
12. **Complete**: `bd close <id> --reason "Done"`
