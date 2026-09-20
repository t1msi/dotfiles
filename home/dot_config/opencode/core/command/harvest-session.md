---
description: Export an OpenCode session plus children, then distill a short compacton. Does not commit JSON.
agent: build
---

Harvest OpenCode session `$ARGUMENTS` (a `ses_*` id) into project instructions.

## Export (do not commit JSON)

```bash
mkdir -p .opencode/harvest
opencode export $ARGUMENTS > .opencode/harvest/$ARGUMENTS.json
```

List children:

```bash
sqlite3 ~/.local/share/opencode/opencode.db \
  "SELECT id, title, agent FROM session WHERE parent_id='$ARGUMENTS';"
```

Export each child the same way. Compaction parts are `part.type = compaction` and `message.agent = compaction`.

## Distill

Do **not** put raw JSON into `AGENTS.md` or always-on `instructions/*.md`. Write markdown under `.opencode/instructions/compactons/` or extend the matching skill.

Prefer `/save-compaction` for one session’s compaction block. Prefer `/save-compaction <ses> <slug> children` to write **per-child** compactons from Task final reports. This command still exports the whole tree’s JSON.

Return: paths of JSON (gitignored) and the distilled markdown (to commit).
