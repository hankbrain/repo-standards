#!/usr/bin/env bash
# Vendor a tagged version of the repo standards base into a consumer repo.
# Usage: refresh-base.sh <tag> [target-dir]
# Run from the consumer repo root. The default target is ./base. The target
# directory is replaced with the contents of the tag, and VERSION inside it
# is set to the tag. Needs curl and tar; no clone of the base is required.
#
# BASE_ARCHIVE_URL overrides the download URL, for testing against a local
# archive (file:// URLs work).
set -euo pipefail

repo="hankbrain/repo-standards"

main() {
  local tag="${1:?usage: $0 <tag> [target-dir]}"
  local target="${2:-base}"

  if ! [[ "$tag" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "tag must look like v1.2.3, got: $tag" >&2
    return 2
  fi
  case "$target" in
    ""|"."|"/"|".."|*/..|../*|/*)
      echo "refusing target: $target" >&2
      return 2
      ;;
  esac

  local url="${BASE_ARCHIVE_URL:-https://github.com/$repo/archive/refs/tags/$tag.tar.gz}"
  local work
  work="$(mktemp -d)"
  trap 'rm -rf "$work"' RETURN

  curl -fsSL "$url" -o "$work/base.tar.gz"
  mkdir "$work/new"
  tar -xzf "$work/base.tar.gz" -C "$work/new" --strip-components=1

  if [ ! -f "$work/new/core/issues.md" ]; then
    echo "archive does not look like the base: core/issues.md missing" >&2
    return 1
  fi

  printf '%s\n' "$tag" > "$work/new/VERSION"

  # Replace in one step at the end, so a failed download leaves the old copy.
  # The script may live inside the target, so nothing runs after the swap.
  rm -rf "$target"
  mkdir -p "$(dirname "$target")"
  mv "$work/new" "$target"
  echo "$target now at $tag"
}

main "$@"
exit $?
