# Module: additional artifacts

Opt-in, for code and research repos.

By default a repo has two artifacts: Issues and the decision log. Some repos
benefit from more, such as a progress log, a risk register, an open-decisions
list, an archive of closed-out research, or a generated decision index.

A repo adds one by declaring it in its adoption record. The declaration states:

- **Name and location.**
- **Purpose.** The one thing it holds that nothing else does.
- **What does not go there.** Where that content goes instead: an Issue, the
  decision log, a commit message.
- **How it is maintained.** By hand, or generated and by what.

## Rules

- **One purpose each.** If an artifact's content would also fit the decision
  log or an Issue, it is not carrying its weight.
- **No duplication.** Do not copy a decision's reasoning into a log, or an
  Issue's status into a register. Link instead.
- **Generated artifacts are read-only views.** Edit the source and regenerate.
  A generated index is never edited by hand.
- **One editable source per list.** If the same items live in two places,
  one of them is the source and the other is a generated view.
