---
name: domain-modelling
description: Build and sharpen the project glossary. Use when discussing terminology, editing CONTEXT.md, or recording an ADR. Also triggered as domain-modeling.
---

# domain-modelling

Active discipline: challenge terms, invent edge-case scenarios, write the glossary and ADRs the moment they crystallise. Reading `CONTEXT.md` for vocabulary is **not** this skill.

This repo's decisions live in `.opencode/adr/` (or `docs/adr/` if that is what the project already uses). Use that tree; do not invent a second ADR folder.

## Files

- Glossary: `CONTEXT.md` at repo root (or paths listed in `CONTEXT-MAP.md`). Format: [CONTEXT-FORMAT.md](CONTEXT-FORMAT.md).
- Decisions: `.opencode/adr/NNNN-slug.md` via `/adr` and `~/.config/opencode/core/adr/template.md`.

Create files lazily.

## During the session

1. If the user conflicts with `CONTEXT.md`, call it out now.
2. If a term is vague, propose one canonical name.
3. Stress-test relationships with concrete scenarios.
4. If they describe behaviour, check the code. Surface contradictions.
5. When a term is resolved, update `CONTEXT.md` immediately. No implementation details in that file.
6. Offer an ADR only when **all three** are true: hard to reverse, surprising without context, real trade-off. Then `/adr` (or write the file and update `INDEX.md`).

Do not treat `CONTEXT.md` as a spec or scratch pad.
