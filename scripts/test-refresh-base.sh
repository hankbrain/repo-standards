#!/usr/bin/env bash
# Tests for refresh-base.sh, using a local archive instead of the network.
# Usage: scripts/test-refresh-base.sh
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd -P)"
script="$here/refresh-base.sh"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

# Build a fake base archive with the top-level directory GitHub adds.
mkdir -p "$tmp/src/repo-standards-0.2.0/core"
echo "# issues" > "$tmp/src/repo-standards-0.2.0/core/issues.md"
tar -czf "$tmp/base.tar.gz" -C "$tmp/src" repo-standards-0.2.0
export BASE_ARCHIVE_URL="file://$tmp/base.tar.gz"

fail=0
check() {
  if [ "$2" = ok ]; then echo "ok   $1"; else echo "FAIL $1"; fail=1; fi
}

# 1. From a subdirectory of a repo: fails, creates nothing.
repo="$tmp/repo"
mkdir -p "$repo/.git" "$repo/base/scripts"
echo old > "$repo/base/VERSION"
if (cd "$repo/base/scripts" && bash "$script" v0.2.0) 2>/dev/null; then
  check "subdirectory fails" no
else
  check "subdirectory fails" ok
fi
[ ! -e "$repo/base/scripts/base" ] && [ "$(cat "$repo/base/VERSION")" = old ] \
  && check "subdirectory changes nothing" ok || check "subdirectory changes nothing" no

# 2. From a non-repo directory: fails, creates nothing.
plain="$tmp/plain"
mkdir "$plain"
if (cd "$plain" && bash "$script" v0.2.0) 2>/dev/null; then
  check "non-repo fails" no
else
  check "non-repo fails" ok
fi
[ -z "$(ls -A "$plain")" ] && check "non-repo changes nothing" ok \
  || check "non-repo changes nothing" no

# 3. From the root: passes, prints the absolute path, sets VERSION.
out="$(cd "$repo" && bash "$script" v0.2.0)"
[ "$out" = "$(cd "$repo" && pwd -P)/base now at v0.2.0" ] \
  && check "root prints absolute path" ok || check "root prints absolute path" no
[ "$(cat "$repo/base/VERSION")" = v0.2.0 ] \
  && check "root updates base" ok || check "root updates base" no

# 4. Worktree-style .git file counts as a root.
wt="$tmp/wt"
mkdir "$wt"
echo "gitdir: elsewhere" > "$wt/.git"
(cd "$wt" && bash "$script" v0.2.0 >/dev/null) \
  && check "worktree .git file accepted" ok || check "worktree .git file accepted" no

# 5. Opt-out works outside a repo.
(cd "$plain" && BASE_SKIP_ROOT_CHECK=1 bash "$script" v0.2.0 >/dev/null) \
  && check "opt-out skips root check" ok || check "opt-out skips root check" no

exit "$fail"
