---
name: land
description: Land the plane - push, PR, clean up, close issues
---

The user wants to land the plane. This means ALL of the following steps MUST complete. The plane is NOT landed until the PR is created. NEVER stop early. NEVER say "ready when you are".

## Step 1: Quality Gates

Only if code changes were made. Run the project's quality checks:

```bash
npm run lint
npm run typecheck
npm run test
```

If any fail, fix them and commit the fixes. If unfixable, create a sub-issue under the parent PRD issue (estimate 0) and continue.

## Step 2: File Remaining Work

Check if anything was left undone or discovered during the session. For each item, create a sub-issue under the parent PRD issue (estimate 0). Do NOT create top-level issues.

## Step 3: Update Linear Issues

- Move completed sub-issues to "Done"
- Update any in-progress issues with current status

## Step 4: Rebase to Main

```bash
git fetch origin
git rebase origin/main
```

If there are conflicts, resolve them and continue the rebase. If conflicts are unresolvable, abort and inform the user.

## Step 5: Push to Remote - MANDATORY

```bash
git push --force-with-lease
git status  # MUST show up to date with remote
```

If push fails, resolve and retry until it succeeds. Do NOT proceed without a successful push.

## Step 6: Create Pull Request

Use `gh pr create`. The PR targets the main branch. Fetch the parent PRD issue from Linear to build the description.

**Title format**: A descriptive Norwegian title explaining what this PR solves

**Body format** (write in Norwegian):

```
[Kort, ikke-teknisk beskrivelse av hva brukeren får ut av dette.]

closes: [parent PRD issue ID only, e.g. NET-100]

## Denne endringen adresserer behovet med

- [Overordnet beskrivelse av hva som er gjort med tekniske detaljer]
- [Tilleggsendringer og side-effects]

## Hva skal testes og hvordan kan man teste det?

- [ ] [Testpunkt 1]
- [ ] [Testpunkt 2]
- [ ] [Testpunkt 3]
```

Only use `closes` for the **parent PRD issue**. Sub-issues are already marked "Done" during execution - do NOT list them in the PR.

## Step 7: Clean Up Git State

```bash
git stash clear
git remote prune origin
```

## Step 8: Verify Clean State

```bash
git status
```

Everything must be committed and pushed. No untracked files that should be tracked.

## Step 9: Report to User

Provide:

1. Summary of what was completed this session
2. Issues filed for follow-up (if any)
3. Quality gate status
4. Confirmation that all changes are pushed
5. Link to the created PR

CRITICAL: The plane has NOT landed until `git push` succeeds and the PR is created. No exceptions.
