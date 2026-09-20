---
name: grilling
description: Grill the user about a plan or design. Use when they say grill, stress-test a decision, or grill-with-docs needs the interview primitive.
---

# grilling

Interview until you share one design tree. Every decision branches. Work in **rounds**.

The **frontier** is every question whose prerequisites are already settled. Ask the whole frontier in one round. Number each question. Give your recommended answer. Then wait.

```
Q1 — <title>: <body and choices>
Recommended: <answer>
```

Do not ask a question that depends on an unanswered question in this same round.

Finding **facts** is your job (read the repo). Finding **decisions** is the user's. Dispatch a read-only agent for facts; do not block the rest of the frontier on it.

Stop when the frontier is empty. Do **not** implement until the user confirms shared understanding.

Prefer the `question` tool when choices are discrete.
