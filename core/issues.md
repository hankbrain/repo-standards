# Issues, labels and decisions

Core for every adopter, code or research. The label shape here is a
suggestion. A repo records what it actually uses in its adoption record, and
anything that differs from the suggestion is noted there as a deviation.

## 1. Issues are the working artifact

GitHub Issues are the only working and pending-work artifact. No per-repo
`TODO.md`, and no project board unless views across many concurrent efforts
become worth the setup cost. That is a decision to log, not a default.

Durable outcomes do not live in issue bodies alone. They go to the artifacts
the repo declares in its adoption record:

- The decision log is the durable historical artifact for why a structural
  call was made. Code repos keep one. For research repos it is opt-in. See
  [`modules/decision-log.md`](../modules/decision-log.md).
- A repo may declare additional artifacts. See
  [`modules/additional-artifacts.md`](../modules/additional-artifacts.md).

Cross-link from the issue that prompted a decision. Do not duplicate the
reasoning into the issue body.

## 2. Labels: a suggested shape

| Dimension | Suggested use |
|---|---|
| `type:*` | What kind of work it is. One per issue. |
| `<dimension>:*` | One primary scope dimension, zero or more per issue. |
| `component:*` | Optional second dimension. See [`modules/component-labels.md`](../modules/component-labels.md). |
| State labels | `needs-triage` and `blocked`. `needs-decision` is optional. |

No other labels are suggested. GitHub's default labels are not part of the
shape.

### `type:*`

| Repo kind | Suggested values |
|---|---|
| Code | `feature`, `bug`, `chore`, optional `tracking` |
| Research | `research`, `task`, optional `tracking`. `architecture` and `doc-update` apply only to repos that adopt the decision log module. |

- `feature`: new capability or enhancement.
- `bug`: something is not working.
- `chore`: maintenance, refactor, documentation or other non-feature work.
- `research`: open-ended investigation.
- `task`: a bounded piece of work that is not research.
- `architecture`: a durable design call that will likely graduate to a
  decision log entry.
- `doc-update`: a content fix to existing reference documents with no
  architectural change.
- `tracking`: a parent issue for a multi-issue effort, paired with a Markdown
  checklist of child issues in its body.

A repo may add values and record them in its adoption record.

### Scope dimension

The base sets the pattern only. Each repo names its own dimension (`area`,
`domain` and `project` are all reasonable) and defines its values. Define
values once the repo has real structure worth splitting on, not before.

### State labels

- `needs-triage`: newly filed, not yet routed or sized.
- `blocked`: cannot proceed yet. See section 3.
- `needs-decision` (optional): waiting on a call that has not been made.

### Defaults and migration

Remove GitHub's default labels that are unused, and rename or merge the ones
that overlap with `type:*` (`bug`, `enhancement`, `documentation`). Renaming
a label in place keeps its issue associations (`gh label edit <old> --name
<new>`). Merging two labels needs a relabel pass before the old label is
deleted.

Existing repos migrate labels when they adopt. Issues that end up with no
type, or more than one, are cleanup during adoption and not a violation of
the base.

## 3. The `blocked` rule

When the blocker is a tracked issue, use GitHub's native blocked-by link.
When it is not, add the `blocked` label and a `## Blocker` heading in the
issue body that names the blocker. The label alone is not enough.

## 4. Filing thresholds

**File an issue** for new features, multi-file refactors, new external
dependencies or integrations, and anything spanning more than one work
session. Skip it for typos, one-line fixes and small document tweaks. Use
judgment, but default to filing rather than silently skipping.

**Log a decision** only when the choice is durable and reusable beyond the
one issue that prompted it, such as a layer-boundary change, a new package
pattern or a repo-wide naming or convention change. Routine implementation
choices stay in the issue.

**A decision file is for a decision, not an action.** Completing a task, a
migration or a rollout is recorded by closing its issue. If the work required
a call that will matter later, that call is the decision.

## 5. Commit and push rule

Restate this locally in every repo's instructions file. Do not rely only on
an inherited personal instruction, because a teammate or a differently
configured agent session may not inherit it.

Never commit or push without explicit instruction. The default flow is to
make changes and stop for review. Commit only when told to, and push only
when told to, separately from the commit.

Use closing keywords in commit messages and pull request descriptions
(`Closes #12`). For an issue in another repo, use `Closes owner/repo#12`.

## 6. Referencing across repos

Reference another repo's issues, decisions and files as `owner/repo#N` or
`owner/repo` plus a path, so the reference survives copying into a different
repo.

## 7. Formatting

Issue, pull request and comment bodies are not hard-wrapped. Write each
paragraph or bullet as a single line and let GitHub wrap it. Those bodies are
not reviewed as diffs, so hard-wrapping only makes the raw view harder to
read.

Markdown files committed to a repo are hard-wrapped at about 80 columns, so
diffs stay clean.

## 8. The adoption record

Applying the base to a repo is itself a setup decision. Record:

- The repo's kind.
- The modules it adopts.
- Its label values, with the mapping from any labels it had before.
- Its additional artifacts.
- Its deviations from the base.
- The base tag it follows.

Log it in the repo's decision log, or in the instructions file if the repo
keeps no decision log. Revisit it when a base refresh changes any of these.
Use [`templates/adoption-record.md`](../templates/adoption-record.md).
