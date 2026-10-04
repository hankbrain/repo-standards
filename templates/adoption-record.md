# Adoption record template

Applying the base to a repo is a setup decision. Log it in the repo's decision
log using the format in [`modules/decision-log.md`](../modules/decision-log.md),
or put it in the repo's instructions file if the repo keeps no decision log.

Copy the block below and fill it in. Keep it short. Link to the base files
instead of restating them.

```markdown
# Adopt the repo standards base

**Date:** YYYY-MM-DD
**Status:** Accepted

## Context

Why the repo is adopting the base now, and what it followed before.

## Decision

**Kind:** code | research

**Base tag:** vX.Y.Z (recorded in `base/VERSION`)

**Profile:** the ecosystem profile this repo also follows, or none.

**Modules adopted:**

- Decision log: yes | no (core for code repos, opt-in for research repos)
- Comments and docstrings: yes | not applicable
- Additional artifacts: none, or the list (see below)
- `component:*` labels: yes, with the values in use | no
- Issue templates: yes | no
- Local development secrets: yes | no
- Dependency locking: yes, with tool, lockfile paths and kind (application or
  library) | no
- Branching and release: yes, with halves adopted and `type:*` prefixes |
  no
- Document drafting lifecycle: yes | not applicable

**Labels in use:**

| Dimension | Values |
|---|---|
| `type:*` | |
| Primary scope dimension (`<name>:*`) | |
| `component:*` | |
| State labels | |

**Label mapping from before adoption:**

| Old label | New label | Notes |
|---|---|---|
| | | |

**Additional artifacts** (name, location, purpose, what does not go there,
how it is maintained):

**Local half of the comment standard** (where displaced comment content goes
in this repo, and any exemptions):

**Deviations from the base**, each with its reason:

## Consequences

What changes in the repo as a result: labels to migrate, files to rename,
instructions to update. Note anything deliberately left undone.
```

Revisit the record when a base refresh changes any of its fields.
