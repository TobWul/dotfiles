# Project mode

Every ticket gets its own PR. Tickets that depend on or overlap each other are **chains**, linked as GitHub stacks.

## Branches

The **base** is `main`, or the branch the user names. A base that is an open PR's branch works: PRs on it retarget to `main` when that PR merges and its branch is deleted. Each ticket uses its own branch name.

Group the tickets into chains. A ticket goes on top of another when it is blocked by it, or when both touch the same component (separate PRs on the same files conflict). A chain is linear: each ticket has at most one parent, because a GitHub stack holds one line and a PR can be in only one stack. When a ticket would need two parents, put the parents in one chain first and the ticket on top. A ticket with nothing above or below it is a chain of one. The bottom ticket branches from the base; each other ticket branches from the one below it.

Done when every ticket sits in exactly one chain, ordered bottom to top.

## Unit

One chain. Dispatch every chain at once (up to the cap): chains don't block each other.

## Finish steps

> Push the branch and open a PR with `gh pr create --base <base>`. Call the Skill tool for "pr" to write the body, and link the ticket. Leave CI to run on its own and leave the PR unmerged. Remove your worktree with `wt remove` once the next ticket's worktree exists or this is your last ticket; the branch stays on the remote.

`ref`: the PR URL.

## Booking a report

Mark every ticket the worker opened a PR for In Review on the tracker, as soon as the report arrives. If the chain has more than one PR, link it: `gh stack link --base <base> <pr> <pr> …`, bottom to top.

## Ship

Give the user a table of every ticket, its PR, and its stack or base, and the merge order: the base PR first if the base is a branch, then each stack bottom up.

Done when every ticket has a PR or a blocked reason in the table, and every ticket with a PR is In Review.
