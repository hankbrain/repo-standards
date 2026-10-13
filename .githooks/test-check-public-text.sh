#!/usr/bin/env bash
# Tests for check-public-text.sh. Usage: .githooks/test-check-public-text.sh
set -uo pipefail
here="$(cd "$(dirname "$0")" && pwd -P)"
script="$here/check-public-text.sh"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
printf '# comment\nacmeapp\nsecret project\n' >"$tmp/deny.txt"
export REPO_STANDARDS_DENYLIST="$tmp/deny.txt"

fail=0
expect() { # name, want (pass|block), text
  local rc=0
  printf '%s\n' "$3" | bash "$script" >/dev/null 2>&1 || rc=$?
  if { [ "$2" = pass ] && [ "$rc" -eq 0 ]; } || { [ "$2" = block ] && [ "$rc" -ne 0 ]; }; then
    echo "ok   $1"
  else
    echo "FAIL $1"; fail=1
  fi
}

expect "generic text passes" pass "An adopter with a UI and a CLI over one service layer."
expect "own issue reference passes" pass "Closes #4 and see hankbrain/repo-standards#4"
expect "own repo URL passes" pass "https://github.com/hankbrain/repo-standards/archive/x.tar.gz"
expect "cross-repo reference blocked" block "see someorg/otherrepo#12"
expect "other repo URL blocked" block "https://github.com/someorg/otherrepo/issues/1"
expect "local path blocked" block "edit /Users/someone/code/file.md"
expect "placeholder owner/repo#N passes" pass "write owner/repo#N for the form"
expect "config dir passes" pass "put it in ~/.config/repo-standards"
expect "tilde path blocked" block "see ~/projects/thing"
expect "trailer noreply address passes" pass "Co-Authored-By: Claude <noreply@anthropic.com>"
expect "email blocked" block "contact a.person@example.com"
expect "denylisted word blocked" block "the AcmeApp domain"
expect "denylisted phrase blocked" block "about the secret project"
expect "denylist is whole-word" pass "an acmeapplication-free sentence"

REPO_STANDARDS_DENYLIST="$tmp/missing.txt" bash "$script" <<<"generic" 2>"$tmp/err" >/dev/null
if [ $? -eq 0 ] && grep -q WARNING "$tmp/err"; then echo "ok   missing denylist warns, still passes"; else echo "FAIL missing denylist warns, still passes"; fail=1; fi

exit $fail
