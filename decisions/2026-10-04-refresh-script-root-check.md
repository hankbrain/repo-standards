# Refresh script root check

**Date:** 2026-10-04
**Status:** Accepted

## Context

`scripts/refresh-base.sh` defaults its target to `./base`, relative to the
current directory, and only its header said to run it from the consumer repo
root. Run from `base/scripts/`, it built a second copy at `base/scripts/base/`,
printed `base now at v0.2.0` and exited 0. The real `base/VERSION` kept the old
tag, and the mistake only surfaced later. The success message gave no path, so
nothing pointed at the wrong location.

## Decision

- The script requires `.git` in the current directory (a directory, or a file
  in a worktree). Otherwise it exits non-zero before downloading anything,
  naming the current directory and the path it would have written to.
- The success message prints the absolute path of the replaced directory.
- `BASE_SKIP_ROOT_CHECK=1` skips the check, for tests and for use outside a
  git repo. It is documented in the script header and the README.
- `scripts/test-refresh-base.sh` covers a subdirectory, a non-repo directory
  and the repo root, plus the worktree and opt-out cases, against a local
  archive.

## Consequences

- A refresh from the wrong directory fails loudly and changes nothing.
- Consumers that vendor `base/` into a non-git directory must set the opt-out.
- Adopters pick this up with their next refresh. The first refresh after
  adoption still runs the downloaded one-off script, which has the check once
  the tag includes it.
