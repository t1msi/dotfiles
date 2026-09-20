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

Agents and commands are **not** loaded from `core/` automatically. Chezmoi
exposes the shared definitions through relative links in the global discovery
directories:

```text
~/.config/opencode/agents/harness-maintainer.md -> ../core/agent/harness-maintainer.md
~/.config/opencode/commands/adr.md -> ../core/command/adr.md
~/.config/opencode/commands/harvest-session.md -> ../core/command/harvest-session.md
~/.config/opencode/commands/save-compaction.md -> ../core/command/save-compaction.md
```

The host project uses `skills.paths` and instruction globs for core files.
Project-local agent and command files are only needed for product-specific
definitions or deliberate overrides of the shared definitions.

## After copy

1. Add product build/architecture to root `AGENTS.md`.
2. Put product always-on files in `.opencode/instructions/*.md` (not `compactons/` or `adr/`).
3. Create `.opencode/adr/INDEX.md` and expose the global `adr.md` command.
4. Restart OpenCode.
