---
description: Save session or subagent notes into compactons (evidence) and record decisions as ADRs via /adr.
agent: build
---

Save OpenCode compaction into the harness.

Arguments: `$ARGUMENTS`
- `$1` = session id (`ses_…`) or `current`
- `$2` = short slug. Default: `session`. With children, this is the **prefix**.
- `$3` = optional `children` | `subagents` | `with-children`

If `$1` is empty, treat as `current`.

## Extract

1. If `$1` is `current` or empty, prefer the latest compaction already in this conversation (after `/compact`). If none **and** `$3` is not children, tell them to run `/compact` first **or** pass a `ses_*` id.
2. If `$1` is a `ses_*` id:

```bash
mkdir -p .opencode/harvest
opencode export $1 > .opencode/harvest/$1.json
```

From the JSON, collect texts from parts with `type` = `compaction` and assistant messages with `agent` = `compaction`. Keep the last structured work-state block if present.

**Subagent / child session:** Task children usually have **no** `/compact` block. If compaction parts are empty, use the **last assistant message** (the final report). Drop tool traces.

3. List children of `$1` (or of `current`’s `ses_*`):

```bash
sqlite3 ~/.local/share/opencode/opencode.db \
  "SELECT id, title, agent FROM session WHERE parent_id='$1';"
```

If `$3` is `children` / `subagents` / `with-children`, export **each child** the same way and write **one compacton per child**. Derive the child slug from `$2` plus a short kebab-case form of the child title, for example `service-bootstrap-api-review`.

If `$1` **is** a child id, save that child only (no need for `$3`).

Do not commit harvest JSON.

## Write

Create `.opencode/instructions/compactons/$2.md` (fallback slug `session`). Children: `.opencode/instructions/compactons/<prefix>-<child>.md`. Never write under `.opencode/instructions/*.md`.

```markdown
# <slug> compaction

Source session: <id>
Parent: <parent id or none>
Agent: <agent or build>
Saved: <ISO date>

## Objective
## Important details
## Work state
### Completed
### Active
### Blocked
## Next move
## Relevant files
```

Drop tool traces, diffs, and secrets. If a matching skill or wanted-* compacton exists, add one line pointing at it. Update `compactons/INDEX.md` (include session id + agent).

If this session **decided or rejected** architecture, also run the `/adr` command (Accepted or Proposed). Compactons are evidence; ADRs are the knowledge base. Do not put either under always-on `instructions/*.md`.

Do not put the compaction into `AGENTS.md` unless it is a project-wide gotcha of ≤3 lines.

## vs `/harvest-session`

`/harvest-session` always exports parent **and** children JSON, then one distill. `/save-compaction … children` writes **per-child** compactons (this is the usual way to keep Task reports). Prefer that when the user says “save the subagents”.

## Finish

Load `small-commits` and commit only the new or updated instruction files:

`harness: save $2 compaction from <session id>`

With children: `harness: save $2 child compactons from <parent id>`
