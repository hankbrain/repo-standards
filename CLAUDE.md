# Repo Instructions: repo-standards

This repo is **public**. It holds generic conventions and nothing about any
specific repo, app, system, organization or person. That rule is in the
README and in `decisions/2026-10-03-three-layers-and-naming.md`; this file
makes it enforceable.

## Public-text rule (hard requirement)

Never write the name of a private repo, app, product, domain, person, or a
local filesystem path, and never link to or reference another repo's issues or
PRs (`owner/repo#N`, or a bare `#N` that means another repo's issue). The rule
applies to everything pushed or posted from here:

- files, including decision files and examples;
- issue titles, bodies and comments;
- pull request titles, bodies and comments;
- commit messages, branch names and tag messages.

Describe the situation generically instead ("a repo with a UI and a CLI over
one service layer", "an adopter"). Examples should be invented, not borrowed
from a real repo.

GitHub keeps the edit history of a public issue, PR or comment. A leak there
survives an edit and is removed only by deleting the item, so check the text
**before** posting, not after.

## Checks

One-time setup per clone:

```sh
git config core.hooksPath .githooks
mkdir -p ~/.config/repo-standards   # then list private names, one per line,
                                    # in denylist.txt there (never in this repo)
```

- `commit-msg` and `pre-commit` hooks check the message, the branch name and
  the added lines.
- Hooks cannot see issue, comment or PR text. Before `gh issue create`,
  `gh issue edit`, `gh pr create` or any comment, write the body to a file
  and run `bash .githooks/check-public-text.sh <file>`. Post only if it
  passes. Do the same for a PR title.
- The denylist lives outside the repo because committing it would leak the
  names it lists. If it is missing, the checker warns; say so rather than
  proceeding as if the check passed.
- `.githooks/test-check-public-text.sh` tests the checker.

## Git and GitHub

- Never commit or push without the maintainer's explicit instruction. Make changes and
  stop for review; commit only when told, and push only when told,
  separately.
- Issue bodies and comments are not hard-wrapped, one line per paragraph or
  bullet. Repo Markdown files are hard-wrapped at about 80 columns.
- Branch from `main` as `<type>/<issue-number>-<slug>` where `<type>` is the
  issue's `type:*` label value, one issue per branch, squash-merge via PR with
  `Closes #N`.
