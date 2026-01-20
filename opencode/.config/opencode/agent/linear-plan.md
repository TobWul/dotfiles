---
description: Makes plans from Linear issues
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

1. Read @AGENTS.md for code style.
2. Read necessary context from the code base to understand how to best solve this issue.
3. Use the `question` tool to ask follow up questions.
4. Convert my feature requirements into structured PRD items.

   Example of PRD item:

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

5. Save to plans/{issue-id}.json
