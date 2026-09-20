# Project (harness core)

Replace this title and the next paragraph with the product name. Keep the layer rules.

## Layers

- **Always-on:** this file + `.opencode/instructions/*.md` (never `compactons/`).
- **Skills:** load with the `skill` tool when the task matches.
- **Subagents:** `@name` or Task. They inherit the parent model unless `model:` is set.
- **ADRs:** `.opencode/adr/` — knowledge base; see `INDEX.md`. Not always-on.
- **Compactons:** `.opencode/instructions/compactons/` — evidence only.
- **Wanted:** ADR Status Proposed. Do not treat as current law.

## Staging and commits

Stage only intended files. Never `git add -A`. Do not commit secrets, `build*/`, `.opencode/harvest/`, or raw session JSON.

When implementing: load `small-commits` (one commit per step; after a failed build the next subject starts with `fix: `) and `explanatory-commits` for the body (`feat:` / `fix:` / `test:` / `docs:` / `harness:` / `build:`).

End a deciding session with `/adr`. Optional evidence: `/save-compaction`.

## Core skills / agents

| When | Load |
|---|---|
| stepwise git commits | skill `small-commits` |
| commit message body | skill `explanatory-commits` |
| numbered Phase 1 / 1.5 / 2 | skill `plan-phases` |
| Grill a plan + write glossary/ADRs | skill `grill-with-docs` |
| Sharpen domain terms / CONTEXT.md | skill `domain-modelling` |
| Simplify the last code change | skill `simplify` |
| Edit `.opencode/` / AGENTS.md / opencode.json | `@harness-maintainer` |

Add product rows below this table.
