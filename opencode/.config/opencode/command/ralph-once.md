---
description: Complete task in prd
---

## Your Task

1. Read @AGENTS.md for code style
1. Read the PRD at @plans/prd.json
1. Read the progress log at @plans/progress.txt
1. Pick a user story where `passes: false`
1. Implement that single user story
1. Run quality checks (e.g., typecheck, lint, test - use whatever your project requires)
1. Update AGENTS.md files if you discover reusable patterns (see below)
1. If checks pass, commit ALL changes with message: `feat: [Story ID] - [Story Title]`
1. Update the PRD to set `passes: true` for the completed story
1. Append your progress to `progress.txt`

## When choosing the next task, prioritize in this order:

1. Architectural decisions and core abstractions
1. Integration points between modules
1. Unknown unknowns and spike work
1. Standard features and implementation
1. Polish, cleanup, and quick wins
   Fail fast on risky work. Save easy wins for later.
