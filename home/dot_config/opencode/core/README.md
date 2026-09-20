# Portable OpenCode harness core

This directory is the canonical, product-independent harness. Chezmoi deploys it
to `~/.config/opencode/core`; projects opt in by referencing that path.

Do **not** copy project-specific sibling agents, instructions, or compactons into the portable core. Those stay in the host project.

## Layout

| Path | Role |
|---|---|
| `AGENTS.md` | Generic conventions. Other projects: use as their root `AGENTS.md`, then add a product section. |
| `opencode.json` | Template. Merge into the project `opencode.json`. |
| `instructions/harness.md` | Always-on layer rules (skills vs agents vs compactons). |
| `skills/` | `small-commits`, `explanatory-commits`, `plan-phases`, `grilling`, `domain-modelling`, `grill-with-docs`, `simplify` |
| `agent/` | Generic harness subagents |
| `command/` | `/adr`, `/save-compaction`, `/harvest-session` |
| `adr/template.md` | ADR file shape |

## Enable in a project

```json
{
  "instructions": [
    "AGENTS.md",
    "~/.config/opencode/core/instructions/*.md",
    ".opencode/instructions/*.md"
  ],
  "skills": {
    "paths": ["~/.config/opencode/core/skills", ".opencode/skills"]
  }
}
```

Agents and commands are **not** loaded from `core/` automatically. Symlink only
the definitions a project uses into `.opencode/agent/` and
`.opencode/command/`.

```bash
ln -s ~/.config/opencode/core/command/save-compaction.md .opencode/command/save-compaction.md
ln -s ~/.config/opencode/core/agent/harness-maintainer.md .opencode/agent/harness-maintainer.md
```

The host project uses `skills.paths` and instruction globs for core files, with
selected agents and commands exposed under its `.opencode/` directory.

## After copy

1. Add product build/architecture to root `AGENTS.md`.
2. Put product always-on files in `.opencode/instructions/*.md` (not `compactons/` or `adr/`).
3. Create `.opencode/adr/INDEX.md` and expose the global `adr.md` command.
4. Restart OpenCode.
