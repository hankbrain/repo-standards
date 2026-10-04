# Module: document drafting lifecycle

Opt-in, for research repos.

Once an Issue discussion converges on producing a final reference document
(a metrics spec, a design document), that document goes through up to three
stages before it is durable. This applies only to documents actually headed
toward durable-reference status, not to every scratch note or draft in an
issue body.

Use a single file, renamed at each stage with `git mv`. The draft and review
files live at the path the ratified document will end up at, not in a separate
`drafts/` folder, so a transition is a rename and not a move. Do not keep
parallel copies at different stages.

| Stage | Name | Meaning |
|---|---|---|
| Draft | `topic-slug.draft.md` | Being written, alone or with an LLM, before review. Any number of commits. No approval implied. |
| Review | `topic-slug.review.md` | Out for review by another person. Revisions are commits on the same file. Do not create `-review-2` variants. History and issue comments carry the trail. |
| Ratified | `topic-slug.md` | Done. The clean, undecorated name is the signal. |

A repo with no second-party reviewer skips the review stage and self-approves
from draft straight to ratified.

The commit or pull request that ratifies a document references the Issue that
spawned it, so there is a trail from discussion to artifact. Add a short
front-matter block recording who approved it and when:

```markdown
---
status: ratified
approved-by: <name>
approved-date: YYYY-MM-DD
---
```

Do not encode revision numbers, approver or date in the filename. Version-style
filenames (`-v0.0.1`, `-v1.0`) conflate which stage a document is in with
which revision it is, and git history already tracks revisions within a stage.

## Relationship to the decision log

Ratifying a document is not a substitute for the decision log. If a ratified
document also represents a durable structural call, add a decision log entry
that links to it. "Ratified" alone is not the decision record.
