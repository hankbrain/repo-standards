# Module: dependency locking

Opt-in, for code repos with third-party dependencies. This module states the
rule only. Which tool produces the lock depends on the language and the kind of
development, so it belongs to a profile or the repo's own adoption record.

## Rule

A repo that depends on third-party packages commits a lockfile: a generated
file that records the exact version of every dependency, direct and transitive.
Builds install from it. They do not resolve versions fresh.

- **Commit the lock.** It covers runtime and development dependencies, so CI
  and local development run the same versions.
- **Install from the lock, never from a fresh resolve.** Local setup, CI and
  container images all use the lock. A build that resolves on its own can pull
  different versions than the ones that were tested and scanned.
- **Updating the lock is a deliberate change.** It goes in its own commit or
  pull request. It is never a side effect of an unrelated build or of adding
  one dependency.
- **Keep the lock and the manifest in step.** The lock is generated from the
  manifest, never edited by hand. CI should fail when the two disagree, so a
  changed dependency list cannot merge without its updated lock.
- **Review the diff.** A lock update changes versions nobody asked for by name.
  Read the diff for surprises before merging.

## Libraries and applications

A library and an application use their locks differently.

- **Application:** the lock decides what is deployed. It is the file the
  deployment installs from.
- **Library:** the published metadata keeps version ranges, so its consumers
  can resolve them against their own dependencies. The library's lock governs
  only its own development and CI. It does not constrain consumers and is not
  what reaches production.

A repo that is both, such as a library with a service wrapper, locks as an
application for the part that deploys.

## What the adoption record states

The base names no tool. The adoption record (or the profile it follows) states:

- **Tool:** what generates and installs from the lock.
- **Lockfile path or paths:** for example, one file, or one each for runtime
  and development.
- **How to update:** the command, and who runs it.
- **Install command:** what builds and images run instead of a fresh resolve.
- **Kind:** application or library, since that decides what the lock governs.

## Not covered

- Language-specific mechanics, such as extras, groups or markers. The tool's
  own documentation covers them.
- Scanning or auditing the locked versions. A repo may run either against the
  lock, but how is its own choice.
- Where a library is published and how consumers pin it. That is a release
  convention, not a locking one.
