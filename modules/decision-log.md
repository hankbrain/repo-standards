# Module: decision log

Core for code repos. Opt-in for research repos.

A decision log is the durable historical artifact: one file per decision,
recording why a structural call was made. Issues carry the discussion. The
log carries the outcome.

## Location

`docs/decisions/` in code repos and `decisions/` in research repos. A repo
that needs a different location records it as a deviation.

## What belongs in it

A decision that is durable and reusable beyond the issue that prompted it.
See the filing thresholds in [`core/issues.md`](../core/issues.md). A decision
file is for a decision, not an action: finishing a migration is recorded by
closing its issue.

Applying the base to a repo is also logged here, as the adoption record.

## File naming

`YYYY-MM-DD-kebab-case-title.md`. Two decisions on the same day are
distinguished by slug only. There is no number to look up or collide on
between parallel branches or sessions, and the date is already a required
field.

## Body

```markdown
# Title

**Date:** YYYY-MM-DD
**Status:** Accepted

## Context

What situation forced this decision?

## Decision

What was decided, concretely.

## Consequences

What changes as a result? What did this deliberately not do? What needs to be
updated elsewhere?
```

Section headings are used rather than bold leads, because bold appears
elsewhere in a body and headings are what readers and tools navigate by.

## Editing and supersession

A decision is never edited after acceptance, except to add one line when a
later decision replaces it:

```markdown
**Superseded by:** 2026-11-02-new-title.md
```

Set the status to `Superseded` at the same time. Pointers to a decision cite
its title or filename, never a number.

Files written before a repo adopted this format are append-only and are not
rewritten. A repo that used numbered names may rename them once, using each
file's own date, if the adoption decision includes an old-name to new-name
table.

## Index

A generated index of decisions is an opt-in additional artifact. See
[`additional-artifacts.md`](additional-artifacts.md).
