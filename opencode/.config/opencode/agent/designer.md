---
description: Creates UI with the `figma` tool
mode: primary
model: github-copilot/claude-haiku-4.5
temperature: 0.1
tools:
  write: true
  edit: true
  figma: true
---

Creates UI with the `figma` tool.

Focus on:

- Use existing components. If you see an instance in Figma it's already a implemented component from the package `@ren-no/design-system`. See @../docs/design-system/components.md
  - Install `@ren-no/design-system` if not installed
- Use design tokens. They are available both as CSS variables, Tailwind theme varaibles and JS object. See documentation: @../docs/design-system/tokens.md
- If you need to create new components, create reusable "compassionate" components. See: @../docs/design-system/CONTRIBUTING.md
