# Group multi-issue work under an epic with sub-issues

**Date:** 2026-11-01
**Status:** Accepted

## Context

`core/issues.md` defined the `tracking` label as a parent issue paired with a
Markdown checklist of child issues. It did not say that children must be
linked as GitHub sub-issues, when an epic should be created, or how deep
nesting may go. An adopter restructuring its issues found several issues
related to an existing epic with no parent, because a checklist entry is not a
parent link. The label itself was used inconsistently: some epics carried it
and some parent issues did not.

## Decision

- An epic is a `type:tracking` issue. Its children are GitHub sub-issues. A
  body checklist is optional and kept only where it adds notes.
- When a second issue joins an effort, ask whether it should be an epic
  instead of requiring one. Two related issues do not always need a parent.
- Each child is one branch, one pull request and one `Closes #N`, matching
  the branching rule. An epic gets no branch.
- No issue that belongs to an effort is left without a parent. Nest at most
  two levels under a top-level domain or area issue. This is a
  recommendation, since GitHub allows more.
- `tracking` is no longer optional in the suggested `type:*` values for code
  and research repos.
- The orphan check is a documented `gh api graphql` query in
  `core/issues.md`, not a script in `scripts/`. It is one call, and a script
  would add a file to maintain and vendor for no gain.
- This is a core rule and not a module. It extends a label that core already
  defines, so there is no opt-in boundary to draw.

## Consequences

- Adopters need the `tracking` label in their label set and a pass over open
  issues to attach children as sub-issues. Each adopter files its own
  follow-up.
- The parent field used by the orphan query depends on GitHub's sub-issues
  feature. If that API changes, the documented query needs updating.
- Soft wording on when to create an epic leaves the call to the filer. The
  orphan check is what catches efforts that were never grouped.
- A new tag is cut after merge so adopters can pick this up with
  `refresh-base.sh`.
