# Module: branching and release

Opt-in, for code repos. A research repo adopts the release half only if other
repos pin it (see "Which half applies").

The module assumes work lands through pull requests. A repo that does not use
them does not adopt it.

Once a repo is versioned and other repos pin it, release mechanics are an
interface between repos. This module states the rule so each repo does not
pick its own scheme and drift. It names no tool and no adopter.

## Branching

- **Trunk-based on `main`.** No long-lived `develop` or `release` branches.
- **Branch name:** `<type>/<issue-number>-<kebab-case-slug>`, for example
  `feature/42-add-export-command`. `<type>` is the issue's `type:*` label
  value verbatim (`feature/`, `chore/`, `bug/`), not the conventional-commits
  abbreviations (`feat`, `fix`). Every issue carries exactly one `type:*`
  label, so the label is the prefix with no translation step, and it works
  for any profile's value set without a fixed list.
- **No `docs/` prefix.** Documentation changes use whatever `type:*` value
  the repo assigns them.
- **`type:tracking` issues get no branch.** They are parents.
- **Names stay generic.** No external tracker keys, people or system names.
  A ticket in another tracker is linked from the issue, not encoded in the
  branch.
- **One issue per branch**, with `Closes #N` in the pull request body. Every
  change that has an issue goes through a branch and a pull request.
- **Exception:** changes below the filing threshold in
  [`core/issues.md`](../core/issues.md) (typos, one-line fixes, small document
  tweaks) may go directly to `main`. They have no issue number to name a
  branch after.
- **Short-lived.** Target under one week. Rebase on `main` daily while the
  branch is active.
- **Squash-merge by default.** Exception: a pure rename or move change, where
  the rename stays its own commit (merge commit or rebase merge) so
  `git log --follow` and blame remain usable. Do not mix content changes into
  that commit.

## Releases

- **SemVer**, staying at `0.x` while the repo's surface is still moving.
  Breaking changes are permitted in `0.x` minors.
- **Minor bump** for new public surface, **patch** for fixes.
- **`CHANGELOG.md`** is updated in the same pull request as the change.
- **Event-driven cadence.** Cut a release when work is complete or a consumer
  needs it, not on a calendar.
- **Consumers pin a tag.** Never a branch, and never a relative-path editable
  install outside local development.

## Which half applies

- A code repo adopts both halves. The release rules depend on pull requests
  (changelog in the same PR, `Closes #N`, squash-merge), so there is no
  release-only option for a repo that commits directly on `main`.
- A research repo needs release mechanics only if it is tagged and vendored by
  other repos, as this base is. It then adopts the release half (versioning,
  tags, pinning) and applies the changelog-in-the-same-PR rule only if it uses
  pull requests. Otherwise it skips the module.

## What the adoption record states

- Which halves it adopts.
- The `type:*` values in use, since they become branch prefixes.
- Where the changelog lives, and the current version.
- Any deviation, with its reason.

## Not covered

- Commit message format beyond the closing-keyword rule in
  [`core/issues.md`](../core/issues.md).
- Build, publish or deploy tooling.
- Where a library is published. Lock behavior is in
  [`dependency-locking.md`](dependency-locking.md).
