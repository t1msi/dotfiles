---
name: plan-phases
description: Use when planning multi-step work, inserting a Phase 1.5, or writing a retrospective progress table. Split the plan into numbered phases with a commit after each.
---

# plan-phases

## Split

1. Write a short **Goal** and the hard constraints.
2. Number phases: `Phase 1`, `Phase 2`, ... Each phase is one mergeable commit (or a tiny `fix:` follow-up).
3. Each phase lists **files**, **done when**, **out of scope**.
4. After the user narrows the scope, insert **Phase 1.5** cut from a later phase. Then **rewrite** remaining Phase 2/3. Do not leave 1.5 secretly finishing 3.

## Execute

- One phase at a time. Commit when that phase is green (`feat: ... phase N - ...`).
- Do not start Phase 2 files in a Phase 1 commit.
- A fight with existing code after the phase lands is a `fix:` after the phase commit.

## Retrospective

When progress happened off-session:

```bash
git log --oneline -20
```

Rebuild the table: Phase | Plan | Landed commits | Still open. Correct later phases. Optional: a compacton under `.opencode/instructions/compactons/`.
