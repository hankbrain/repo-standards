# Three layers and naming

**Date:** 2026-10-03
**Status:** Accepted

## Context

The same person maintains repos across more than one ecosystem. Each grew
similar conventions for Issues, labels and decision logs independently, with
small differences, and switching between the sets costs attention for no
benefit.

Treating one ecosystem's standard as the parent of the others does not work.
That standard names its own repos, systems and vocabularies throughout, and
removing the names leaves the shape of one ecosystem behind. A parent should
hold only what every ecosystem shares.

## Decision

Split the conventions into three layers:

| Layer | Holds |
|---|---|
| Base (`repo-standards`) | Generic rules and the mechanisms each repo fills in. A small core plus opt-in modules. No organization, ecosystem, system, repo or person names. |
| Ecosystem profile (`repo-standards-<ecosystem>`) | Values shared by two or more repos that are not generic, such as label vocabularies, naming of secrets, and the list of repos to roll a change out to. Plus ecosystem-wide deviations. |
| Repo | The adoption record: kind, modules, label values, artifacts and deviations. |

A profile exists only when two or more repos share non-generic values. A
single repo's additions go in its own instructions file. If that repo later
gains siblings that share those values, the group gets a profile.

Applicability is by kind, not by name. A code repo has a real codebase and
build, lint or test tooling. A research repo's output is reference
documentation. A repo decides which it is. The base keeps no list of
consumers. A profile may keep one, because rolling a change out across an
ecosystem needs it.

The base requires nothing it cannot justify generically. The label shape and
default values are suggestions that a repo records and, where it differs,
records as a deviation.

## Consequences

- Each ecosystem's own values move into its profile. Carve-outs for a single
  repo move to that repo's adoption record, and become a base rule only if
  they should be allowed generally.
- The base README states the naming rule.
- Cross-repo personal rules with no profile above them stay in the owner's
  personal instructions, not in the base.
