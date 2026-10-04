# Branching and release module

**Date:** 2026-10-04
**Status:** Accepted

## Context

The base covered labels, the Issues-versus-decisions split, filing thresholds,
templates and the commit and push rule, and said nothing about branch names,
merge strategy, versioning or releases. That stops being a per-repo preference
once a repo is versioned and other repos pin it, because release mechanics
become an interface between repos.

No adopter has exercised a draft yet. The module is written from the draft in
#2, and the open questions are resolved below on the best available reasoning
rather than adopter evidence. The draft's question about direct-on-`main`
repos is answered by requiring branches, since several other rules assume a
pull request. The first adopter that finds a rule that does
not hold should propose a change here.

## Decision

- Add an opt-in module,
  [`modules/branching-and-release.md`](../modules/branching-and-release.md),
  for code repos.
- Trunk-based on `main`. Branches are named `<type>/<issue-number>-<slug>`,
  with `<type>` the issue's `type:*` label value verbatim.
- Squash-merge by default. A pure rename or move change is the named
  exception and keeps the rename as its own commit, so `git log --follow` and
  blame stay usable.
- SemVer, `0.x` while the surface moves, event-driven releases, changelog
  updated in the same pull request, consumers pin a tag.
- Code repos branch for every change that has an issue. The exception is a
  change below the filing threshold in `core/issues.md`, which may go directly
  to `main`. A repo that does not use pull requests does not adopt the module,
  because the release rules (changelog in the same PR, `Closes #N`,
  squash-merge) depend on them. There is no release-only option.
- A research repo adopts the release half only if other repos pin it.
- The adoption record template gains a line for the module.

## Consequences

- Adopters refresh `base/` to pick up the module and update their adoption
  record. Nothing else in a refresh changes for them.
- Existing repos that commit directly on `main` must change their workflow to
  adopt, or skip the module.
- The resolved questions are provisional until an adopter tests them.
- A new base tag follows this decision.
