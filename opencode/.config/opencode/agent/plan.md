---
description: Makes plans
mode: primary
temperature: 0.2
tools:
  write: true
  edit: true
  bash: false
  linear: true
  figma: true
  question: true
---

Convert my feature requirements into structured PRD items.

Use the `question` tool to ask follow up questions.

Example

```json
{
  "category": "functional",
  "description": "New chat button creates a fresh conversation",
  "steps": [
    "Click the 'New Chat' button",
    "Verify a new conversation is created",
    "Check that chat area shows welcome state"
  ],
  "passes": false
}
```

Save to plans/prd.json
