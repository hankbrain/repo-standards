# Module: agent-operable CLI

Opt-in, for code repos that expose features through both a UI and a CLI.

The goal is that no session has to ask for a manual step, or re-derive logic
the UI already has. A session here means an LLM agent or a script: something
that can run a command and read its output but cannot click through a page.
This module states when a feature gets a non-interactive CLI command and what
that command looks like.

## Precondition

The repo has a service layer that both the UI and the CLI call. Business logic
lives there, and neither the UI nor the CLI owns it.

A repo without one adds the service layer first or does not adopt the module.
A CLI-only repo, or a UI-only repo, has nothing for this module to decide.

## Trigger

A new UI feature, or a new service function, gets a CLI command in the same
change when a session could plausibly need to run or read it without a
browser. That means any of:

1. **It refreshes, imports, exports or applies something.** A cache refresh,
   an import, an export, a bulk write.
2. **It reads derived data that a direct query cannot cheaply reproduce.**
   Logic that lives in code (computed tiers, conflicts, aggregates) rather
   than in a stored column.

## Non-triggers

A feature that is neither of those gets no command:

- Plain browsing and filtering of stored columns. A session reads these with a
  direct query.
- Row-level add, edit and delete that generic admin CRUD already covers.
- Pure presentation: charts, rendered pages, templates.

Requiring a command for every route would add dead commands that duplicate a
query.

## Shape of a command

- **Non-interactive.** Flags in, structured output on stdout for reads (JSON),
  so a session can run it. An interactive menu entry is optional and wraps the
  same function. A feature that exists only as a menu prompt does not meet
  this module.
- **One implementation.** The command and the UI route call the same service
  function. Logic goes in the service first.
- **Preview by default.** A write that is bulk or hard to undo shows what it
  would do and writes only with an explicit `--apply`.
- **Tests ship with it.** The command is tested in the same change.
- **The entry-point map stays current.** If the repo keeps a document mapping
  features to their commands, routes and service functions, the same change
  updates it. A stale map is worse than none.

## Exceptions

- A feature that is deliberately UI-only, because it is useless without the
  page, may skip the command if the pull request or Issue says why in one
  line.
- A command that cannot run in a bare session, for example because only the
  running server may touch some resource, still gets a command. That is a
  reason to document how it runs, not to skip it. The adoption record states
  any such repo-specific exception.

## What the adoption record states

The base names no CLI framework, output schema or web stack. The adoption
record states:

- **Service layer:** where it lives, so the precondition is checkable.
- **Command shape:** the CLI framework and how a command is invoked, if the
  repo differs from the flags-in, JSON-out default.
- **Entry-point map:** the document that lists commands, or none.
- **Repo-specific exceptions:** anything beyond the two above.
