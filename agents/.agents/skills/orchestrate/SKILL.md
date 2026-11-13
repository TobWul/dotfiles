---
name: orchestrate
description: "Implement tickets end to end with parallel workers in their own worktrees: a spec merged into one spec branch and shipped as one PR, or a project's tickets as one PR each, stacked where they overlap."
argument-hint: "Spec reference (issue or .scratch path), or a project, label or ticket filter"
disable-model-invocation: true
---

You are the **orchestrator**. Workers write the code; you hold the ticket graph, dispatch, relay notes, close workers down, and ship. Stay **thin**: your context carries tickets, branch names, commits or PRs, and worker reports. Workers read the code and the diffs, so you never need to.

The issue tracker should have been provided to you. If not, tell the user to run `/setup-matt-pocock-skills`.

## Mode

The argument decides the **mode**:

- **Spec mode**: a spec (an issue with sub-issues, or a `.scratch/<spec-slug>/` folder). Workers merge into one spec branch, shipped as one PR. Read [`SPEC.md`](SPEC.md).
- **Project mode**: a project, a label, a filter, or a list of tickets. Each ticket gets its own PR; tickets that depend on or overlap each other are stacked. Read [`PROJECT.md`](PROJECT.md).

When the argument fits neither, ask the user which mode to run. The mode file fills in the marked parts below: the branches, the unit of dispatch, the worker's finish steps, the bookkeeping on each report, and how the run ships.

## 1. Load the graph

Fetch the tickets. For each record its ID, title, branch name (Linear's `gitBranchName`, or `<NN>-<ticket-slug>` locally), **blockers**, and the components or files it touches. If a spec has no tickets yet, stop and tell the user to run `/to-tickets`.

Done when every ticket is listed with its blockers and touch set.

## 2. Set up branches

Follow the mode file. Done when its completion criterion holds.

## 3. Dispatch

Dispatch one worker per **unit** (the mode file defines it), in the background, at most **6 at a time**: every worker installs, builds, and runs tests, and more than that overloads the machine until timeouts drown real failures. Queue the rest. Use the brief below verbatim with the blanks filled in.

When a worker reports:

1. **Close it down.** If its notification says it still has background work running, stop it with TaskStop.
2. **Book it** as the mode file says.
3. **Relay.** Append environment gotchas the worker hit (broken installs, known flaky tests, tooling quirks) to the **known issues** of every later brief. Notes for later tickets ride along in their briefs. When notes touch a running worker's files, tell that worker with SendMessage.
4. **Refill** the free slot from the queue.

A **blocked** ticket: re-dispatch with the missing context if the spec or a report supplies it; otherwise ask the user. Everything that depends on it waits.

Done when every unit has reported and no worker is running.

<worker-brief>

You are implementing <the unit's tickets, in order>, in <repo path>.

<per ticket: ID, title, branch name, and the base to branch from>

Known issues in this environment: <gotchas relayed from earlier reports, or "none yet">

For each ticket, in order:

1. Run `git fetch`, then create your worktree: `wt switch --create <branch> --base <base> --no-cd`, and do all work in the worktree path it prints.
2. Fetch the ticket and its comments from the tracker for the full acceptance criteria. Triage comments can narrow the scope; follow them.
3. Implement it. Call the Skill tool for "tdd" where possible. Run typechecking and single test files regularly, and the full test suite plus lint once at the end. Other workers run tests on this machine at the same time: rerun a timeout on its own before you call it a failure.
4. Call the Skill tool for "code-review" to review the work against the ticket, and fix what it finds.
5. Commit to the ticket branch. When the change breaks something for users of the code, describe it in the commit body, and leave the release level to the user.
6. Stop every server or test process you started.
7. <finish steps from the mode file>

A blocked ticket gets no finish step; skip it, and skip the tickets after it in your list.

Reply with only this report:

```
ticket: <ID> | status: done | blocked | ref: <from the mode file> | reason: <one line, if blocked>
(one line per ticket)
notes: <breaking changes, scope decisions, gotchas, interfaces later tickets need, and possible follow-ups, or "none">
```

</worker-brief>

## 4. Ship

Follow the mode file. Then give the user the **decisions** workers left to them (breaking changes and release levels, scope calls, expected conflicts) and the **follow-ups** they flagged out of scope, and offer to file the follow-ups as tickets.

Done when the mode file's ship criterion holds and no worker or worktree from this run is left.
