# Module: `component:*` labels

Opt-in, for code repos.

`component:*` is an optional second label dimension. It names the components
a repo touches, so that one issue about a component means the same thing
wherever it is filed. A component can be:

- an **external system or piece of infrastructure** the repo depends on or
  integrates with, or
- a **component of a larger system** that more than one repo contributes to
  or depends on, such as a shared library, a service or a subsystem.

## Mechanism

- **Identical names across an ecosystem.** Unlike the primary scope
  dimension, whose values describe one repo's own internal structure, a
  `component:*` name is the same in every repo that uses it. That makes
  cross-repo work on one component trackable with one label instead of
  several local spellings.
- **Added on evidence.** A repo gets a `component:*` label when it has real
  evidence that it uses or touches that component: a config key, an
  environment example entry, a dependency manifest entry, or an import or
  interface to another repo's component. Add the label the same day the
  evidence appears, not before, and not the whole vocabulary "just in case".
- **The vocabulary is not in the base.** The list of names is content for an
  ecosystem profile, or for the repo's own adoption record when no profile
  exists. Add a name to the vocabulary first, then to the repos that need it.

## Component or scope value?

If the name is meaningful only inside one repo's own layers or subsystems,
it is a value of the primary scope dimension. If the same name needs to mean
the same thing across repos, it is a component. A name that starts as a
scope value in one repo becomes a component once a second repo needs it.

## When it does not apply

A research repo does not integrate with external systems or build components
directly, so there is nothing for the dimension to track. A research repo
that starts doing so is probably a code repo.
