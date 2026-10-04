# Decision file format

**Date:** 2026-10-03
**Status:** Accepted

## Context

Decision files existed in two shapes across repos: sequentially numbered files
with section headings, and date-named files with bold-lead bodies. A numbered
scheme needs a "next number" lookup and collides when parallel branches or
sessions add decisions at once. The date is already a required field. Bold
leads are used elsewhere in a body, whereas headings are what readers and
tools navigate by.

Counted across the repos in question, the date-named files were the majority
by a wide margin.

## Decision

- Name files `YYYY-MM-DD-kebab-case-title.md`. Same-day decisions are
  distinguished by slug.
- Body: `# Title`, then `**Date:**` and `**Status:**` lines, then `##
  Context`, `## Decision` and `## Consequences`.
- A superseded decision gains one `**Superseded by:**` line naming the later
  file, and its status becomes `Superseded`. Pointers cite a title or
  filename, never a number.
- The format applies to decisions written from adoption onward. Existing
  files are append-only and are not rewritten. A repo that renames numbered
  files does it once, using each file's own date, and records an old-name to
  new-name table in its adoption decision.
- A generated index is an opt-in additional artifact.

## Consequences

- Repos with numbered files rename them when they adopt, or leave them as
  they are.
- Pointers written before adoption that cite numbers keep working only until
  the rename. Update them in the same change.
- The format is specified in
  [`modules/decision-log.md`](../modules/decision-log.md).
