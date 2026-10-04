# Comment standard and widened scope

**Date:** 2026-10-03
**Status:** Accepted

## Context

Until now the conventions covered Issues, labels and decision logs. Nothing
said what a comment or docstring should contain, so each repo, and each LLM
session, improvised. Sessions tend to write what they just learned into the
nearest docstring, and later sessions copy the style they see.

An audit of one Python codebase of about 9,300 lines found that 21% of lines
were docstrings or comments, 74 docstrings ran longer than six lines, and
about 335 comments referred to issue numbers, dates, decision log entries or
words like "formerly" and "added". The content fell into five kinds: stale or
wrong claims, change history narrated in code, decision rationale duplicated
from the decision log, cross-reference chains, and genuine constraints. A
spot check of eleven history and rationale passages found every one already
recorded in a decision or progress log, so removing them loses nothing.

The decision log is already the only durable historical artifact. This applies
that rule to code.

## Decision

- The base also covers code comment conventions. Its README and scope
  description state this.
- The standard is its own file in the core, for code repos:
  [`core/comments.md`](../core/comments.md). It sits apart from the Issues
  and labels document so that file stays focused and a repo can adopt the
  standard on its own.
- The rules are language-neutral. "Docstring" means any documentation
  comment.
- Vendored and generated code are exempt, including a consumer's vendored
  `base/` directory. Migrations and run-once scripts are not exempt: they
  describe the change they make, which is their contract and not history.
  Tests follow the same rules, and a regression test may name the issue it
  reproduces.
- Enforcement is review only. The standard describes a grep check that a repo
  may add. The base ships no checker. If two repos write their own, that is
  the evidence for adding one.
- Each repo's adoption record holds the local half: where displaced content
  goes in that repo, and any further exemptions as deviations.
- Research repos have no code and are not affected.

## Consequences

- Each code repo records its local half in its adoption record when it
  adopts, then cleans up existing comments at its own pace. Adoption does not
  have to be simultaneous, and no cleanup is required for the standard itself
  to land.
- Examples in the standard stay generic, like everything in the base.
