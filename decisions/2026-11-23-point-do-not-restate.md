# Point at rules instead of restating them

**Date:** 2026-11-23
**Status:** Accepted

## Context

Adopters kept paraphrased copies of base rules in their instructions files,
and repos kept paraphrased copies of profile rules. A refresh updates the
vendored base but not those copies, so they drifted. This surfaced when the
branching exception was tightened and several instructions files still
carried the old wording as their own text.

The standard never said what belongs in an instructions file. The README
said only that instructions point at the base. Section 6 of `core/issues.md`
asks every repo to restate the commit and push rule, and that deliberate
exception read as a general habit.

## Decision

- Each layer states only what belongs to it and points at the layer above
  for the rest. This applies to the base, an ecosystem profile and a repo.
- The commit and push rule is the only rule restated in full, because it must
  hold even when nothing else is read. A restated rule names its source
  file.
- After a refresh, the instructions file is searched for rules the new tag
  changed. The adoption record template says so.

## Consequences

- Existing paraphrased copies are converted to pointers. Each adopter and
  profile files its own follow-up when it refreshes.
- Fewer manual edits when a rule changes.
- A pointer gives an agent that does not follow links less to work with than
  inline text. The section 6 exception covers the rule where that matters
  most.
