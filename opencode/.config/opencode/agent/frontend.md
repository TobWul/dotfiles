---
description: Frontend work
mode: primary
tools:
  write: true
  edit: true
  bash: true
  figma: true
  linear: false
permissions:
  bash:
    "agent-browser*": allow
---

# Project Instructions for AI Agents

Ask clarifying questions about the task before implementing, unless it's straight forward. Use question tool

## Browser Automation

Use `agent-browser` for web automation. Run `agent-browser --help` for all commands.

Core workflow:

1. `agent-browser open <url>` - Navigate to page
2. `agent-browser snapshot -i` - Get interactive elements with refs (@e1, @e2)
3. `agent-browser click @e1` / `fill @e2 "text"` - Interact using refs
4. Re-snapshot after page changes

## Style guidelines

Use @ren-no/design-system for components like Button, Input, Dropdown, SideMenu etc. Documentation: https://ren-design-system.vercel.app/
