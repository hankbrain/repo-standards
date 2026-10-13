# repo-standards

Personal working conventions for how a repo uses GitHub Issues, labels,
decision logs and code comments. The conventions are suggestions. Each repo
adopts what fits and records where it differs.

This repo holds no code. It is meant to be vendored into other repos and
pointed at from their instructions files (`CLAUDE.md`, `AGENTS.md` or
similar), instead of copying the same prose into every repo and letting the
copies drift.

## Scope

- How a repo uses Issues and labels, and when something becomes an Issue
  versus a decision.
- How a repo keeps a decision log and any additional record artifacts.
- How code comments and docstrings are written.
- A few opt-in modules for adjacent practices: issue templates, local
  development secrets, dependency locking, branching and release,
  agent-operable CLI, document drafting.

## Contents

| Path | Holds |
|---|---|
| [`core/issues.md`](core/issues.md) | Issues, the suggested label shape, the `blocked` rule, filing thresholds, commit and push rule, the adoption record. Every adopter. |
| [`core/comments.md`](core/comments.md) | Comment and docstring standard. Code repos. |
| [`modules/`](modules/) | Opt-in practices, one file each. A repo declares which it adopts. |
| [`templates/`](templates/) | The adoption record template and generic issue templates. |
| [`scripts/refresh-base.sh`](scripts/refresh-base.sh) | Vendors a tagged version of this repo into a consumer. |
| [`decisions/`](decisions/) | Why the conventions are shaped the way they are. |

## Kinds of repo

A repo decides which kind it is.

- **Code repo:** has a real codebase and build, lint or test tooling.
- **Research repo:** its output is reference documentation or design notes.
  It has no build or test surface.

The core applies to both. Some modules apply to one kind only, and each
module file says which.

## The three layers

| Layer | Holds | Lives in |
|---|---|---|
| Base | Generic rules and the mechanisms each repo fills in. No names of organizations, systems, repos or people. | This repo |
| Ecosystem profile | Values shared by two or more repos that are not generic: label vocabularies, vault and item naming, the list of repos to roll a change out to. | `repo-standards-<ecosystem>` |
| Repo | The adoption record: kind, modules, label values, artifacts and deviations. | The repo's instructions file, backed by a logged decision |

A profile exists only when two or more repos share non-generic values. A
single repo's additions go in its own instructions file, not in a profile
repo. If that repo later gains siblings that share those values, the group
gets a profile.

## Adopting the base

1. Decide the repo's kind and which modules it adopts.
2. Vendor the base at a tag. From the repo root:

   ```sh
   curl -fsSL -o refresh-base.sh \
     https://raw.githubusercontent.com/hankbrain/repo-standards/<tag>/scripts/refresh-base.sh
   bash refresh-base.sh <tag>
   rm refresh-base.sh
   ```

   This creates `base/` containing the tagged contents and `base/VERSION`
   containing the tag.
3. Write the adoption record ([`templates/adoption-record.md`](templates/adoption-record.md)).
   Log it in the repo's decision log, or in the instructions file if the repo
   keeps no decision log.
4. Point the repo's instructions file at the files under `base/` instead of
   restating them. State locally anything that must not depend on an
   inherited instruction, such as the commit and push rule.
5. Migrate labels to the suggested shape, or record the differences as
   deviations.

Adoption does not have to be simultaneous across repos, and a repo can adopt
the core first and add modules later.

## Refreshing

Never edit `base/` in place. A change to a generic rule is made here first
and then pulled in. Run this from the repo root; the script refuses to run
from anywhere without a `.git` entry:

```sh
bash base/scripts/refresh-base.sh <new-tag>
```

The script replaces `base/` with the new tag and rewrites `base/VERSION`.
It prints the absolute path it replaced. Set `BASE_SKIP_ROOT_CHECK=1` to
skip the root check outside a git repo.
Review the diff, and revisit the adoption record if a change affects any of
its fields.

## Versioning

Tags follow SemVer, starting at `v0.1.0`. A tag is cut each time a decision
in [`decisions/`](decisions/) is accepted, and each consumer's `base/VERSION`
records the tag it follows.

## Contributing

This repo is public and holds nothing specific to any private repo, app or
person. Hooks in `.githooks/` check commit messages, branch names and added
lines for private names. After cloning:

```sh
git config core.hooksPath .githooks
mkdir -p ~/.config/repo-standards
```

Then list the names to block, one per line, in
`~/.config/repo-standards/denylist.txt`. The denylist stays outside the repo
because committing it would publish the names. Without it the hooks still
block references to other repos, local paths and email addresses, but warn
that the name check did not run. Hooks cannot see issue, comment or pull
request text, so run `bash .githooks/check-public-text.sh <file>` on a body
before posting it. See `CLAUDE.md` for the full rule.

## License

MIT. See [`LICENSE`](LICENSE).
