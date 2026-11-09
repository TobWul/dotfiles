---
name: prototype
description: Build a throwaway prototype to answer a design question, as a small HTML demo for logic or Paper designs for UI. Use when the user wants to sanity-check whether a state model or logic feels right, or explore what a UI should look like.
---

# Prototype

A prototype is a **throwaway** that answers one question. The question decides the medium.

## Pick a branch

Work out which question is being answered from the user's prompt and the surrounding code, or ask if the user is around:

- **"Does this logic / state model feel right?"** → [LOGIC.md](LOGIC.md). Build something simple in code: a single HTML file with a pure logic module and buttons that push it through the cases that are hard to reason about on paper.
- **"What should this look like?"** → [UI.md](UI.md). Design several radically different variants in Paper, following the project's UI design practices.

The two branches produce very different things, so picking wrong wastes the whole prototype. If the question is genuinely ambiguous and the user isn't reachable, pick the branch that matches the surrounding code (a backend module → logic; a page or component → UI) and state the assumption at the top of the prototype.

## Rules for both branches

1. **Throwaway, and marked as one.** Anyone who finds it can tell at a glance it's a prototype, not production code or a final design.
2. **Skip the polish.** No tests, no error handling beyond what makes it work, no abstractions, no pixel-pushing. The point is to learn something fast.
3. **Capture it when done.** Record the answer (the verdict and the question it settled) on the implementation issue, fold the validated decision into the real code or design, and leave a context pointer on the issue to the prototype itself, which stays as a **primary source**. Each branch says where its prototype lives.
