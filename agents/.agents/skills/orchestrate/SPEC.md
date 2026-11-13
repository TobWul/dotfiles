# Spec mode

Every ticket merges into one **spec branch**, shipped to `main` as one PR.

## Branches

On Linear, the spec branch `<spec-branch>` is the spec issue's `gitBranchName`, so Linear links the branch and PR to the issue. On a local tracker, use `<spec-slug>`. Branch it from `main` and push it:

```sh
wt switch --create <spec-branch> --base main --no-cd
git -C <worktree path printed by wt> push -u origin <spec-branch>
```

Ticket branches are named `<spec-branch>--<NN>-<ticket-slug>`. Use the double dash: git refuses a `<spec-branch>/…` branch while `<spec-branch>` exists. Every ticket branches from `<spec-branch>`.

Done when the spec branch is on the remote and the **frontier** (tickets whose blockers are all merged) is non-empty.

## Unit

One ticket from the frontier. Dispatch the whole frontier at once (up to the cap); blockers gate everything else.

## Finish steps

> From inside your worktree run `wt merge <spec-branch>`: it squashes, rebases onto the spec branch, fast-forwards it, and removes your worktree. If the rebase conflicts, resolve, re-run the tests, and run it again.

`ref`: the squashed commit sha on the spec branch.

## Booking a report

Mark each `done` ticket Done on the tracker, recompute the frontier, and dispatch every newly unblocked ticket right away. Leave running workers alone.

## Ship

In the spec branch worktree, run the full test suite and typecheck. Fix anything red by dispatching a worker with the failure output as its ticket.

Push the spec branch and open a PR to `main` with `gh pr create`. Call the Skill tool for "pr" to write the body, and link the spec in it. Mark the spec issue In Review on the tracker.

Done when every sub-issue is Done, the spec issue is In Review, CI-equivalent checks pass locally, and the PR URL is in your final message.
