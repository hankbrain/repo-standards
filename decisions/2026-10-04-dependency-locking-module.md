# Dependency locking module

**Date:** 2026-10-04
**Status:** Accepted

## Context

Repos in the same ecosystem were inconsistent about lockfiles. Some committed
one, some had an unpinned requirements file, and some had nothing. A container
image built with a fresh resolve can contain different transitive versions
than the ones that were tested and scanned, and the difference is invisible
until something breaks.

A specific tool cannot be a base rule. Locking tools are specific to a language
and ecosystem, and a repo outside that ecosystem would have nothing to follow.
What does generalize is that a lock exists and builds install from it.

Libraries and applications also differ. A library publishes version ranges so
its consumers can resolve. Its own lock covers only its development and CI. The
consumer's lock decides what is deployed.

## Decision

- Add an opt-in module, [`modules/dependency-locking.md`](../modules/dependency-locking.md),
  for code repos with third-party dependencies.
- The module requires a committed lock covering runtime and development
  dependencies, installs from the lock in every build, and makes updating the
  lock a deliberate change of its own. It also asks CI to fail when the lock and
  the manifest disagree.
- A library keeps ranges in its published metadata. Its lock governs only its
  own development and CI.
- The base names no tool. The adoption record, or the profile a repo follows,
  states the tool, lockfile paths, update command and install command.
- The adoption record template gains a line for the module.

## Consequences

- A profile or repo that adopts the module must choose a tool and record it.
  Until it does, the module is only a stated intent.
- Repos that already have a lock under a tool of their choice are not forced to
  change tools. They record the tool in their adoption record.
- Adopters refresh `base/` to pick up the module, then update their adoption
  record. The module is a new file, so a refresh changes nothing else for them.
- This decision does not cover branching or release conventions, which are a
  separate module.
