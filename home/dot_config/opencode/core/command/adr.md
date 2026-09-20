---
description: Record this session as an Architecture Decision Record under .opencode/adr.
agent: build
---

Write or update an ADR from this session. Knowledge base is **ADRs**, not always-on files and not compactons.

Arguments: `$ARGUMENTS`
- `$1` = session id (`ses_…`) or `current` (default `current`)
- `$2` = kebab-case slug (required if new). Example: `hid-per-role-settings`

## When

Run at the **end of every session** that decided, rejected, or confirmed architecture — including “we will not do X”. If the session only fixed a typo, skip.

## Number

Next free `NNNN` in `.opencode/adr/` (this project) or the path `AGENTS.md` names. Never reuse a number. Never write under `instructions/*.md`.

## File

`.opencode/adr/NNNN-<slug>.md` using `~/.config/opencode/core/adr/template.md`:

- **Accepted** — current law
- **Proposed** — wanted, not implemented
- **Superseded** — point to the replacement ADR
- **Session** — work log with no new rule (rare; prefer compacton)

One decision per file. If the session made three decisions, write three ADRs.

## Body

Context / Decision / Consequences / Evidence. Drop tool traces, diffs, secrets. Link evidence compactons if they exist. Update `.opencode/adr/INDEX.md`.

If this only restates an existing Accepted ADR, **do not** duplicate. Add a one-line Evidence note on the existing file instead.

## Finish

`harness: adr NNNN <slug>` via `small-commits`. Tell the user to restart only if `opencode.json` changed (it should not).
