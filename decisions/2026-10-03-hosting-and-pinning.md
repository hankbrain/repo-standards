# Hosting and pinning

**Date:** 2026-10-03
**Status:** Accepted

## Context

Consumers sit under different accounts, and the accounts cannot read each
other's private repos. A parent that lives under one account makes the repos
under another depend on something outside their own account. Consumers also
need a stable copy: a convention that changes underneath a repo with no
record is hard to reason about.

## Decision

- **Hosting.** The base is a public repo under the personal account, with an
  MIT license. Public hosting lets every consumer read it with no access
  arrangement.
- **Vendoring.** Every consumer vendors a pinned copy of the base into its own
  `base/` directory. A profile holds one copy that every adopter of that
  profile reads. A repo with no profile above it vendors its own.
- **Refresh script.** The base ships `scripts/refresh-base.sh`. It takes a
  tag, downloads that tag from the public repo, replaces `base/` with it, and
  writes the tag to `base/VERSION`. It needs no local clone of the base.
- **Never edit `base/` in place.** A change to a generic rule is made in the
  base first and then pulled in.
- **Tags.** SemVer, starting at `v0.1.0`. A tag is cut each time a decision
  is accepted.
- **No clone needed.** No machine needs a clone of the base except to edit it.
- **References run one way.** Files in consumers may point at the base. The
  base does not point at its consumers.

## Consequences

- Everything in the base is public. Its decisions and examples describe the
  conventions in generic terms.
- A consumer's `base/VERSION` is the record of which tag it follows.
- Vendored copies are exempt from the comment standard, as vendored code.
