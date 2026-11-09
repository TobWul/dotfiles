---
name: orchestrate
description: "Implement a ticketed spec end to end: parallel workers in their own worktrees, merged into one spec branch, shipped as one PR."
argument-hint: "Spec reference (issue number, URL, or .scratch path)"
disable-model-invocation: true
---

You are the **orchestrator**. Workers write the code; you hold the ticket graph, dispatch, merge results, and ship. Stay **thin**: your context carries tickets, branch names, and worker reports. Workers read the code and the diffs, so you never need to.

The issue tracker should have been provided to you. If not, tell the user to run `/setup-matt-pocock-skills`.

## 1. Load the graph

Fetch the spec and every ticket under it (sub-issues on a real tracker, `.scratch/<spec-slug>/issues/` locally). For each ticket record its ID, title, and **blocking edges**. If the spec has no tickets yet, stop and tell the user to run `/to-tickets`.

Done when every ticket is listed with its blockers, and the **frontier** (tickets whose blockers are all done) is non-empty.

## 2. Create the spec branch

On Linear, the spec branch `<spec-branch>` is the spec issue's `gitBranchName`, so Linear links the branch and PR to the issue. On a local tracker, use `<spec-slug>`. Branch it from `main` and push it:

```sh
wt switch --create <spec-branch> --base main --no-cd
git -C <worktree path printed by wt> push -u origin <spec-branch>
```

Ticket branches are named `<spec-branch>--<NN>-<ticket-slug>`. Use the double dash: git refuses a `<spec-branch>/…` branch while `<spec-branch>` exists.

## 3. Work the frontier

Dispatch one worker per frontier ticket, all in a single message so they run in parallel, each in the background. Use the brief below verbatim with the blanks filled in.

When a worker reports back:

- **merged**: mark the ticket done on the tracker, recompute the frontier, and dispatch every newly unblocked ticket right away. Leave running workers alone.
- **blocked**: read the reason. Re-dispatch with the missing context if you can supply it from the spec or another report; otherwise ask the user. Keep its dependants off the frontier until it merges.

Notes a worker flags for later tickets ride along in the briefs of those tickets.

Done when every ticket is merged into the spec branch.

<worker-brief>

You are implementing ticket <ID>: <title>, part of spec <spec reference>.

1. Create your worktree off the spec branch: `wt switch --create <ticket-branch> --base <spec-branch> --no-cd`, then do all work in the worktree path it prints.
2. Fetch the ticket from the tracker for the full acceptance criteria.
3. Implement it. Call the Skill tool for "tdd" where possible, at pre-agreed seams. Run typechecking and single test files regularly, and the full test suite once at the end.
4. Call the Skill tool for "code-review" to review the work, and fix what it finds.
5. Commit your work to your ticket branch.
6. From inside your worktree run `wt merge <spec-branch>`: it squashes, rebases onto the spec branch, fast-forwards it, and removes your worktree. If the rebase conflicts, resolve, re-run the tests, and run it again.
7. Reply with only this report:

```
ticket: <ID>
status: merged | blocked
commit: <your squashed commit sha on the spec branch, if merged>
reason: <one line, if blocked>
notes for later tickets: <interfaces or decisions downstream tickets must know, or "none">
```

</worker-brief>

## 4. Ship

In the spec branch worktree, run the full test suite and typecheck. Fix anything red by dispatching a worker with the failure output, same brief, with the failure as its ticket.

Push the spec branch and open a PR to `main` with `gh pr create`. Call the Skill tool for "pr" to write the body, and link the spec in it.

Done when CI-equivalent checks pass locally and the PR URL is in your final message to the user.
