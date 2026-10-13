# Guardrails against leaking private names into this repo

**Date:** 2026-10-13
**Status:** Accepted

## Context

The base is public and must stay generic. The README and the three-layers
decision already say it carries no organization, system, repo or person names,
but nothing enforced that, and the repo had no instructions file for a session
working in it. While adding a module, issue text named private repos and
cross-linked their issues. GitHub keeps the edit history of a public issue, so
editing the body did not remove the names. Only deleting the issue did.

A leak is hardest to undo in issue, comment and pull request text, because
that text is public the moment it is posted and git hooks cannot see it.

## Decision

- Add `CLAUDE.md` stating the rule and where it applies: files, issue and pull
  request titles, bodies and comments, commit messages, branch names and tag
  messages. Text is checked before it is posted, not after.
- Add `.githooks/check-public-text.sh`. Built-in checks need no private
  knowledge: references to other repos (`owner/repo#N`), links to other repos,
  local filesystem paths and email addresses. A denylist of private names is
  read from outside the repo, because committing it would publish the names.
- Wire the checker as `commit-msg` (message and branch name) and `pre-commit`
  (added lines) hooks, enabled with `git config core.hooksPath .githooks`.
  Issue, comment and pull request text is checked by running the script on a
  body file before posting.
- A missing denylist warns loudly and still runs the built-in checks, so a
  fresh clone is not blocked but is not silently unprotected either.
- Mark the instructions file and hooks `export-ignore`, so the archive that
  consumers vendor does not carry repo-specific instructions into their
  sessions.

## Consequences

- Each clone needs a one-time hooks setup and a denylist. Both are documented
  in `CLAUDE.md`. Hooks are local, so a clone without them is unprotected;
  the instructions file is the fallback.
- The hooks cannot stop text posted from the web interface or by a session
  that skips the check. A pull request check using the built-in patterns only
  would be a backstop, but it runs after the text is public, so it is deferred.
- Existing history was reviewed when this was written and held no private
  names after the earlier issue was deleted and recreated.
