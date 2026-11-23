# Branch before editing documents that belong to an issue

**Date:** 2026-11-23
**Status:** Accepted

## Context

The branching module lets changes below the filing threshold go directly to
`main`, and listed "small document tweaks" among them. Adopters repeatedly
made a document edit (a decision file, a progress entry, a regenerated index)
on `main` because it looked small. The work then continued under the same
issue, and no branch was created until a person asked for one. Size was being
judged per edit, when the rule is about whether the change belongs to an
issue.

## Decision

- Only typos and one-line fixes below the filing threshold go directly to
  `main`. "Small document tweaks" is removed from the exception in
  `modules/branching-and-release.md` and from the skip list in
  `core/issues.md` section 4.
- A document change that belongs to an issue is not below the threshold,
  however small. The issue's branch is created before the first edit.
- If the change was already made on `main`, it moves to the issue's branch
  before it is committed.

This clarifies the existing rule that every change with an issue goes through
a branch and a pull request. It adds no new requirement.

## Consequences

- Adopters pick this up with their next refresh. No adoption record field
  changes.
- A repo whose agent instructions restate the exception should align them
  with the new wording.
- A small amount of branch overhead for document edits that were previously
  made on `main`, in exchange for no stray commits on `main`.
