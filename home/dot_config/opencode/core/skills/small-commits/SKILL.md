---
name: small-commits
description: Use when implementing, building, or fixing code. Commit every completed step. After a failed build, the next commit message starts with fix:. Git worktrees allowed for parallel work.
---

# small-commits

This skill **overrides** the default “do not commit unless asked”. Commit each finished step.

## When to commit

1. A coherent change that compiles in your head (new files, a working slice).
2. **Immediately before** a full project build (checkpoint).
3. After a **successful** build/lint of that step.
4. After a **failed** build: fix, then commit the fix only.

Do not squash. Do not amend unless the user asks. Do not `git push` unless asked.

## Messages

Load skill `explanatory-commits` for the HEREDOC body.

- Subject: `feat:` / `fix:` / `test:` / `docs:` / `harness:` / `build:` plus imperative summary.
- **Failed build then fix:** subject **must** start with `fix: `.

One logical change per commit. Stage only intended files. Never `git add -A`. Root `AGENTS.md` may list extra do-not-commit paths.

Before every commit:

```bash
git status
git diff
git log --oneline -10
```

Then `git add` intended paths, `git commit` with a HEREDOC. No `--amend`, no `--no-verify`, no force, no config changes.

## Failed build loop

1. Checkpoint commit exists.
2. Build fails.
3. Fix only the reported error.
4. Commit: `fix: …`
5. Rebuild. Another failure → another `fix:` commit.

## Worktrees

```bash
git worktree add /tmp/opencode/<project>-<task> -b wip/<task>
```

Commit inside that worktree. Do not mix two worktrees in one commit.

## Do not commit

Secrets, `build*/`, `.opencode/harvest/`, raw session JSON. Plus any paths listed in the project `AGENTS.md`.
