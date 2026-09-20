# Harness core (portable)

Not product law. Product always-on files add architecture and build.

## What loads

| Kind | Typical path | When |
|---|---|---|
| Always-on | `AGENTS.md`, `instructions/*.md` | Every session |
| Skill | `skills/<name>/SKILL.md` | `skill` tool |
| Subagent | `agent/<name>.md` | `@name` / Task |
| Command | `command/<name>.md` | `/name` |
| Compacton | `instructions/compactons/<slug>.md` | Evidence only |
| ADR | `adr/NNNN-*.md` | Knowledge base; open on purpose |

`instructions/*.md` is always-on. Compactons and ADRs **must not** live in that glob.

`@alias` in `opencode.json` `references` is a folder, not a subagent.

## ADRs

Canonical decisions: `.opencode/adr/INDEX.md` (project) using `core/adr/template.md`. End every deciding session with `/adr current <slug>`. Status Proposed ≠ Accepted.

Compactons are session/evidence notes (`/save-compaction`; add `children` for Task reports). `/harvest-session` exports JSON then distill.

## Config

Validate `opencode.json` against https://opencode.ai/config.json. Unknown top-level keys prevent startup. Restart OpenCode after config/agent/skill changes.
