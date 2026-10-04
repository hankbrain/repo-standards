# Adoption record

**Date:** 2026-10-03
**Status:** Accepted

## Context

The base suggests a label shape and leaves values, artifacts and some modules
to each repo. Without a place to say what a repo actually chose, a reader
cannot tell a deliberate difference from drift, and a base refresh cannot be
checked against the repo it lands in.

## Decision

Applying the base to a repo is itself a setup decision, called the adoption
record. It states:

- the repo's kind (code or research),
- the modules it adopts,
- its label values, with the mapping from any labels it had before,
- its additional artifacts,
- its deviations from the base, each with its reason,
- the base tag it follows.

It is logged in the repo's decision log, or in the repo's instructions file if
the repo keeps no decision log. It is revisited when a base refresh changes
any of those fields. The template is
[`templates/adoption-record.md`](../templates/adoption-record.md).

The base suggests labels rather than requiring them. Repos record what they
actually use, and anything that differs from the suggestion is noted as a
deviation.

## Consequences

- A repo that adopts takes on a one-time write-up and a revisit when a
  refresh affects it.
- The adoption record is where a single repo's carve-out lives. A carve-out
  that should be allowed generally is proposed as a base change instead.
- Tracking adoption across repos is the owner's concern in each ecosystem
  (a profile's tracking issue, or an issue in each repo). It is not tracked
  in the base.
