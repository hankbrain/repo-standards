# Agent-operable CLI module

**Date:** 2026-10-13
**Status:** Accepted

## Context

A repo with a UI and a CLI over one service layer shipped a UI-only refresh
button. Whether it needed a command came up only afterward, because the repo
had no stated standard. The only guidance was indirect, and the gap was found
by an audit that then filed follow-up issues for other UI-only features that
sessions needed from the command line.

The rule that came out of it names nothing specific to that repo. It applies
to any repo whose UI and CLI share a service layer. Left in one repo, each
sibling would rediscover or reinvent it and the copies would drift.

Checked when this was written: one repo adopts it. A second repo with a CLI
has no UI and no service layer, so there is no UI-only feature for the trigger
to catch. A third has no shared service layer and will not adopt. The module is
written from one adopter, as the branching module was. The first adopter that
finds a rule that does not hold should propose a change here.

## Decision

- Add an opt-in module,
  [`modules/agent-operable-cli.md`](../modules/agent-operable-cli.md), for code
  repos that expose features through both a UI and a CLI.
- Scope it as "a UI and a CLI over a shared service layer", not as a general
  CLI standard. The service layer is a stated precondition.
- A feature gets a command when it refreshes, imports, exports or applies
  something, or reads derived data a direct query cannot cheaply reproduce.
  Plain browsing of stored columns, covered admin CRUD and pure presentation
  get none.
- A command is non-interactive with structured output, shares its
  implementation with the UI route, previews bulk or hard-to-undo writes
  unless given `--apply`, ships with tests, and updates the repo's
  entry-point map.
- The output contract stays at "JSON on stdout". Stable keys, exit codes and
  error format are left out until an adopter needs them, rather than guessed.
- The entry-point map rule is a line in this module, not a separate docs
  module, because only the repo that has such a map is affected.
- The adoption record template gains a line for the module.

## Consequences

- Adopters refresh `base/` to pick up the module, then update their adoption
  record. The module is a new file, so a refresh changes nothing else for them.
- An adopter keeps its own environment-specific exceptions in its adoption
  record and its own decision log. An existing repo-level rule that this
  module now owns is superseded by a new decision file there, not edited.
- A new base tag is cut after this lands.
- This decision does not define an output schema. That is deferred until a
  second adopter or a consumer needs one.
