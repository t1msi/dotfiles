---
name: grill-with-docs
description: Use when the user wants a grilling session that also updates CONTEXT.md and ADRs. Load before designing a feature or choosing architecture.
---

# grill-with-docs

Load skill `grilling` and skill `domain-modelling`. Then run the interview.

As answers settle:

- Sharpen terms into `CONTEXT.md` (glossary only).
- Record hard-to-reverse trade-offs with `/adr` under `.opencode/adr/`.

Do not implement until the user confirms the frontier is empty. Do not dump the interview into always-on `instructions/*.md`.
