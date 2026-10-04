# Module: issue templates

Opt-in, for code and research repos.

The templates in [`../templates/issue/`](../templates/issue/) are generic
starting points. Copy them into the repo's `.github/ISSUE_TEMPLATE/` and
adapt them.

| Template | Use | Label preselected |
|---|---|---|
| `feature_change.yml` | A new feature or non-trivial change. Code repos. | `type:feature` |
| `tracking.yml` | A parent issue with a checklist of child issues. | `type:tracking` |
| `decision_proposal.yml` | A proposed durable decision. Repos with a decision log. | `type:architecture` |

## Adapting

- **Reword the layer or impact field** to the repo's own vocabulary. The
  generic wording asks whether a change crosses a boundary or adds a
  dependency. A repo with a named layering scheme should name its layers.
- **Match the label names** to the repo's adoption record. If a repo uses
  different `type:*` values, change the `labels` line.
- **Keep the fields stable** otherwise. The shared shape (summary, context,
  proposal or approach, impact, related issues) is what makes issues readable
  across repos.

Template bodies are not hard-wrapped, like any issue body.
