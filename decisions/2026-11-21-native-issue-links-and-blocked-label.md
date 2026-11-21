# Use native issue links and always apply the blocked label

**Date:** 2026-11-21
**Status:** Accepted

## Context

Adopters recorded parents, blockers and relations inconsistently. Some used
only text in the body (a checklist entry, "blocked by", "see"), which GitHub
cannot query, show in the sidebar or clear automatically. The epics rule
required native sub-issue links for epic children only, so a parent outside
an epic, such as an area issue, was not covered.

Section 3 of `core/issues.md` treated the native blocked-by link and the
`blocked` label as alternatives: link when the blocker is an issue, label plus
a `## Blocker` heading when it is not. That gave two different "blocked"
signals depending on the blocker, so no single filter found every blocked
issue.

GitHub now offers parent, blocked-by, blocking and relates-to links natively,
and the GraphQL `Issue` type exposes `parent`, `blockedBy`, `blocking` and
`relatesTo`.

## Decision

- Record every relationship between issues with the native link: parent
  (sub-issue), blocked-by or blocking, relates-to. A body mention or
  checklist entry is not a substitute, though it may remain as context.
- Parents are not limited to epics. Any issue that belongs to a larger effort
  or area gets a native parent. This extends the epics rule, and does not
  replace it.
- The `blocked` label is always applied to an issue that cannot proceed,
  whatever the blocker is. This replaces the alternative wording of section 3.
- When the blocker is an issue, also add the native blocked-by link. When it
  is not an issue, the label plus a `## Blocker` heading naming it is the
  record.
- Remove the label when the issue is unblocked.
- The checks are a documented `gh api graphql` query in `core/issues.md`, not
  a script, for the same reason as the orphan query. It lists open issues with
  a blocked-by link to an open issue and no label, and issues with the label
  whose blocked-by links are all closed. A label with no link is expected and
  not listed.
- The issue templates' "related" field descriptions point to the native
  relates-to link.
- This stays in core, since it amends an existing core rule.

## Consequences

- Adopters need a pass over open issues to convert body-only parents,
  blockers and relations to native links, and to add `blocked` where a native
  link exists without it. Each adopter files its own follow-up.
- A stale `blocked` label is the main new failure mode. The check query
  catches it when the blockers were issues.
- The checks depend on GitHub's issue dependency and relationship API. If it
  changes, the documented query needs updating.
- A new tag is cut after merge so adopters can pick this up with
  `refresh-base.sh`.

Builds on `2026-11-01-epics-and-sub-issues.md`.
