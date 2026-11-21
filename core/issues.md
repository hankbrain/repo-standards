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
| Code | `feature`, `bug`, `chore`, `tracking` |
| Research | `research`, `task`, `tracking`. `architecture` and `doc-update` apply only to repos that adopt the decision log module. |

- `feature`: new capability or enhancement.
- `bug`: something is not working.
- `chore`: maintenance, refactor, documentation or other non-feature work.
- `research`: open-ended investigation.
- `task`: a bounded piece of work that is not research.
- `architecture`: a durable design call that will likely graduate to a
  decision log entry.
- `doc-update`: a content fix to existing reference documents with no
  architectural change.
- `tracking`: an epic, a parent issue for a multi-issue effort. Its children
  are GitHub sub-issues. See section 5.

A repo may add values and record them in its adoption record.

### Scope dimension

The base sets the pattern only. Each repo names its own dimension (`area`,
`domain` and `project` are all reasonable) and defines its values. Define
values once the repo has real structure worth splitting on, not before.

### State labels

- `needs-triage`: newly filed, not yet routed or sized.
- `blocked`: cannot proceed yet. Always applied to a blocked issue. See
  section 3.
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

## 3. Native links and the `blocked` rule

Record every relationship between issues with GitHub's native link, not with
text. A mention in the body or a checklist entry is not a substitute, because
GitHub cannot query it, show it in the sidebar or clear it automatically. A
body mention is still fine as extra context.

| Relationship | Native link |
|---|---|
| Belongs to a larger effort or area | Parent (sub-issue) |
| Cannot proceed until another issue closes | Blocked by (or blocking, from the other side) |
| Related, with no dependency | Relates to |

- **Apply the `blocked` label to any issue that cannot proceed**, whatever
  the blocker is. One label gives one filter that finds every blocked issue.
- **When the blocker is an issue, also add the native blocked-by link.**
- **When the blocker is not an issue** (an external dependency, a decision, a
  person, a date), the label plus a `## Blocker` heading in the issue body
  naming it is the record. The heading is also useful beside a link when
  there is context to add, but is only required for the non-issue case.
- **Remove the label when the issue is unblocked.** GitHub clears its own
  blocked indicator when the blocker closes, but the label stays until
  someone removes it.

Parents are covered in section 5. They are not limited to epics.

### Checking blocked state

List open issues whose labels and native links disagree. Run it from a clone,
so `gh` fills in the owner and repo. The query reads up to 20 labels and 50
blockers per issue.

```sh
gh api graphql --paginate -F owner='{owner}' -F name='{repo}' -f query='
query($owner:String!,$name:String!,$endCursor:String){
  repository(owner:$owner,name:$name){
    issues(states:OPEN,first:100,after:$endCursor){
      nodes{
        number title
        labels(first:20){nodes{name}}
        blockedBy(first:50){nodes{number state}}
      }
      pageInfo{hasNextPage endCursor}
    }
  }
}' --jq '.data.repository.issues.nodes[]
  | (.labels.nodes|map(.name)|index("blocked")!=null) as $label
  | (.blockedBy.nodes|map(select(.state=="OPEN"))|length) as $open
  | (.blockedBy.nodes|length) as $links
  | if $open>0 and ($label|not) then "missing label: #\(.number) \(.title)"
    elif $label and $links>0 and $open==0 then "stale label: #\(.number) \(.title)"
    else empty end'
```

- `missing label`: a native blocked-by link to an open issue, but no
  `blocked` label. Add the label.
- `stale label`: the label, with native blocked-by links that are all closed.
  Remove the label, or check whether the real blocker was never an issue.

An issue with the label and no link at all is expected (a non-issue blocker)
and is not listed.

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

## 5. Epics and sub-issues

An epic is a `type:tracking` issue. Its body states the overall outcome and
the feature set. Its children are real GitHub sub-issues (the parent link),
not only a checklist. A body checklist is optional and kept only where it adds
notes.

- **When a second issue joins an effort, ask whether it should be an epic.**
  Two related issues do not always need one. If it should, create the epic
  and attach both, so the parent is not retrofitted later. A one-off below the
  filing threshold needs no epic.
- **Each child is a small, deployable chunk:** one branch, one pull request,
  one `Closes #N`. An epic itself gets no branch (see
  [`modules/branching-and-release.md`](../modules/branching-and-release.md)).
- **No issue that belongs to an effort is left without a parent.** The parent
  is a native link, and it need not be an epic: an area or domain issue is a
  valid parent for work that belongs to it. Nest at most two levels under a
  top-level domain or area issue (area, then project, then work). GitHub
  allows deeper nesting, but two is the recommendation.
- **Check for orphans** by listing open issues that have no parent. Review the
  result and place or close each one. Issues that are genuine one-offs
  are expected in the list.

```sh
gh api graphql --paginate -F owner='{owner}' -F name='{repo}' -f query='
query($owner:String!,$name:String!,$endCursor:String){
  repository(owner:$owner,name:$name){
    issues(states:OPEN,first:100,after:$endCursor){
      nodes{number title parent{number}}
      pageInfo{hasNextPage endCursor}
    }
  }
}' --jq '.data.repository.issues.nodes[]|select(.parent==null)|"#\(.number) \(.title)"'
```

Run it from a clone, so `gh` fills in the owner and repo.

## 6. Commit and push rule

Restate this locally in every repo's instructions file. Do not rely only on
an inherited personal instruction, because a teammate or a differently
configured agent session may not inherit it.

Never commit or push without explicit instruction. The default flow is to
make changes and stop for review. Commit only when told to, and push only
when told to, separately from the commit.

Use closing keywords in commit messages and pull request descriptions
(`Closes #12`). For an issue in another repo, use `Closes owner/repo#12`.

## 7. Referencing across repos

Reference another repo's issues, decisions and files as `owner/repo#N` or
`owner/repo` plus a path, so the reference survives copying into a different
repo.

## 8. Formatting

Issue, pull request and comment bodies are not hard-wrapped. Write each
paragraph or bullet as a single line and let GitHub wrap it. Those bodies are
not reviewed as diffs, so hard-wrapping only makes the raw view harder to
read.

Markdown files committed to a repo are hard-wrapped at about 80 columns, so
diffs stay clean.

## 9. The adoption record

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
