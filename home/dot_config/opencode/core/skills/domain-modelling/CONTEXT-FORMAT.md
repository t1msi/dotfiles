# CONTEXT.md format

Glossary only. No implementation, no specs.

```md
# {Context name}

{One or two sentences: what this context is.}

## Language

**Order**:
{What it is.}
_Avoid_: Purchase, transaction
```

- Pick one canonical term. List aliases under `_Avoid_`.
- One or two sentences. What it **is**, not what it does.
- Only project-specific domain terms. No generic programming words (timeout, error, thread).
- Group under subheadings when clusters appear.

Single context: one `CONTEXT.md` at the repo root.

Multiple contexts: `CONTEXT-MAP.md` at the root listing each `CONTEXT.md` and how they relate.

If neither exists, create root `CONTEXT.md` when the first term is resolved.
