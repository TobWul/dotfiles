---
description: Work through Linear issues one at a time
---

## Your Task

The user has provided a Linear issue. Use it to fetch the relevant sub-issues.

1. Fetch issues from Linear (sub-issues of parent)
2. Determine order: unblocked issues first (by blocking relationships), then by priority
3. Pick the next issue that is not "Done" or "In Progress"
4. Move it to "In Progress" in Linear
5. Implement that single issue
6. Run quality checks (typecheck, lint, test)
7. If checks pass, commit with message: `feat: [Issue ID] - [Issue Title]`
8. Move issue to "Done" in Linear

/tdd skill

ONLY WORK ON A SINGLE ISSUE.

If all issues are "Done", output <promise>COMPLETE</promise>. Otherwise, never output this string.

IMPORTANT, DO NOT EVER TYPE OUT <promise>COMPLETE</promise> UNLESS ALL ISSUES ARE DONE. NOT EVEN IN THINKING
