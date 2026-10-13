#!/usr/bin/env bash
# Fail if text names something private. This repo is public.
# Usage: check-public-text.sh [file ...]   (reads stdin with no files, or "-")
#
# Built-in checks need no private knowledge: references to other repos
# (owner/repo#N), GitHub URLs to other repos, local filesystem paths and email
# addresses (the public commit-trailer noreply addresses are allowed). A denylist of private names is read from
# $REPO_STANDARDS_DENYLIST (default ~/.config/repo-standards/denylist.txt),
# one case-insensitive word or phrase per line, '#' for comments. The denylist
# must live outside this repo, since committing it would leak the names.
# A missing denylist is a loud warning, not a failure.
set -uo pipefail

self_repo="hankbrain/repo-standards"
denylist="${REPO_STANDARDS_DENYLIST:-$HOME/.config/repo-standards/denylist.txt}"

check_text() {
  local label="$1" text="$2" bad=0 hit
  hit="$(grep -nEo '[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+#[0-9]+' <<<"$text" \
    | grep -v -e "$self_repo#" -e '^[0-9]*:owner/repo#' || true)"
  [ -n "$hit" ] && { echo "$label: reference to another repo: $hit" >&2; bad=1; }

  hit="$(grep -nEo 'github\.com[/:][A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+' <<<"$text" \
    | grep -v "$self_repo" || true)"
  [ -n "$hit" ] && { echo "$label: link to another repo: $hit" >&2; bad=1; }

  hit="$(grep -nEo '(/Users/|/home/)[A-Za-z0-9_.-]+|~/[A-Za-z0-9_.-]+' <<<"$text" \
    | grep -v '~/\.config$' || true)"
  [ -n "$hit" ] && { echo "$label: local path: $hit" >&2; bad=1; }

  hit="$(grep -nEo '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' <<<"$text" \
    | grep -v -e '@anthropic\.com$' -e '@users\.noreply\.github\.com$' || true)"
  [ -n "$hit" ] && { echo "$label: email address: $hit" >&2; bad=1; }

  if [ -f "$denylist" ]; then
    local term
    while IFS= read -r term; do
      case "$term" in ''|'#'*) continue ;; esac
      hit="$(grep -niwF -- "$term" <<<"$text" | head -3 || true)"
      [ -n "$hit" ] && { echo "$label: denylisted name '$term': $hit" >&2; bad=1; }
    done <"$denylist"
  fi
  return $bad
}

main() {
  if [ ! -f "$denylist" ]; then
    echo "WARNING: no denylist at $denylist; only built-in checks ran." >&2
  fi
  local rc=0
  if [ "$#" -eq 0 ]; then set -- -; fi
  local f
  for f in "$@"; do
    if [ "$f" = - ]; then
      check_text "stdin" "$(cat)" || rc=1
    else
      check_text "$f" "$(cat "$f")" || rc=1
    fi
  done
  [ "$rc" -ne 0 ] && echo "Blocked: this repo is public. Make the text generic." >&2
  return $rc
}

main "$@"
