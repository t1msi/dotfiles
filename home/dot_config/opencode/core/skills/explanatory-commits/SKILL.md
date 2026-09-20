---
name: explanatory-commits
description: Use when writing git commit messages after a completed step. First line is type-prefixed summary; body lists implementation steps and optional notes.
---

# explanatory-commits

Use with skill `small-commits`. This skill is **how** to write the message.

HEREDOC. Wrap body at ~72 columns. No `--amend`.

## First line

```
<type>: <imperative summary>
```

| Type | When |
|---|---|
| `feat:` | New behavior, port, API, UI |
| `fix:` | Build failure or bug after a step (required after a failed build) |
| `test:` | Tests and how-to-run docs only |
| `docs:` | README / comments / harness prose without product code |
| `harness:` | `.opencode/`, `AGENTS.md`, `opencode.json` |
| `build:` | Build-system-only, or a build checkpoint |

Summary: one line, no period, what changed — not “update files”.

Blank line after the subject.

## Body

Lead with **where this sits** (phase, which feature) if it is part of a numbered plan.

Then `- ` bullets of **what landed** (types, APIs, behavior), not a file list. Say what was **not** done when it would be assumed.

Optional last paragraph: how it was verified, leftover risk.

Skip notes only for trivial `fix:` one-liners.

## Do not

- Subject-only messages on a completed feature step.
- `git commit -m "feat: stuff"` without a body when the diff is more than a one-line fix.
- Restate `git diff --stat` as the body.
