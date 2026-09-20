---
name: simplify
description: Use after writing or editing code to simplify it for clarity. Do not change behavior. Trigger on simplify, refine, clean up the last change.
---

# simplify

Refine **recently modified** code only (this session / current diff). Do not change what it does.

Source idea: [brianlovin/agent-config `simplify`](https://github.com/brianlovin/agent-config/blob/main/skills/simplify/SKILL.md). Follow **this repo's** `AGENTS.md` and ADRs, not React/ESM rules.

## Do

- Flatten needless nesting; delete dead branches and unused names
- Prefer names a later reader can grep; match neighboring files
- Prefer existing helpers over a new abstraction
- Keep one concern per function when a merge would hide control flow
- Prefer `if`/`switch` over nested ternaries

## Do not

- Change outputs, public APIs, persisted or wire formats, ownership, or thread-safety guarantees
- Touch files you did not just edit unless the user expands the scope
- Add comments that merely restate the code
- Golf line count; explicit is better than clever
- Invent a parallel framework or abstraction layer
- Reformat the whole file

## Process

1. `git diff` (and unstaged edits) — that is the scope.
2. Apply the smallest clarity edits.
3. If a test or lint command is known, run it on what you touched.
4. Stop. Do not start a second feature.

Do not run this skill unprompted after every edit.
