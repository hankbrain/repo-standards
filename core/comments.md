# Comments and docstrings

Core for code repos. Research repos have no code and are not affected.

Comments and docstrings describe the code as it is now. A comment should
need editing only when the code it describes changes. Change history,
decision rationale and attribution live in Issues, the decision log and
commit messages instead.

"Docstring" here means any documentation comment, in any language.

## Why

Sessions, human or LLM, tend to write what they just learned into the nearest
comment, and later sessions copy the style they see. The result is a
predictable set of problems:

1. **Stale or wrong claims.** "No models defined yet" above a package that
   has twelve. Nobody updates narrative when the code moves on.
2. **Change history narrated in code.** "Correction: the original version of
   this query...", "added for #N".
3. **Decision rationale duplicated from the decision log.** Paragraphs on
   alternatives considered, next to a decision file that says the same thing.
4. **Cross-reference chains.** "Same reasoning as X", "mirrors Y". They break
   silently on rename.
5. **Genuine constraints**, which are what comments are for, and which are
   hard to find among the rest.

Kinds 2 and 3 are already recorded elsewhere, so removing them loses nothing.
The decision log is the only durable historical artifact, and this standard
applies that rule to code.

## The rules

1. **Say what the names and signature do not.** The contract (what is
   returned, what is raised, side effects) and any non-obvious constraint or
   workaround.
2. **No change history.** No dates, and no "added", "formerly", "originally",
   "correction", "supersedes" or "no longer".
3. **No decision rationale beyond one sentence** that stops a reader from
   "fixing" the code. The full reasoning stays in the decision log, with at
   most one pointer by decision title.
4. **No attribution or conversation.** Who asked for it, who caught the bug,
   what was said.
5. **Issue numbers only where the code is waiting on that issue.** A TODO, a
   lint or coverage suppression, or a temporary stand-in. Not as provenance
   tags.
6. **No forward-looking status** ("will be added", "not built yet"). That is
   an Issue.
7. **Cross-references to other code only where the coupling is real**, meaning
   the two must change together.
8. **A wrong comment is a bug.** Fix it in the same change that makes it
   wrong.

### Example

Before:

```python
def active_users(db):
    """Return active users.

    Correction (caught in review): the original version of this query
    included deactivated accounts. Changed when #212 was fixed. Same
    reasoning as the billing query. Will be paginated later.
    """
```

After:

```python
def active_users(db):
    """Return users whose account is not deactivated, ordered by id."""
```

The history, the rationale and the pagination plan already live in the issue
and its closing comment. Had the query excluded deactivated accounts for a
reason that would tempt a reader to "fix" it, that one sentence would stay.

## Scope

- **Vendored and generated code are exempt.** This includes a consumer's
  vendored `base/` directory. Tool-generated headers (revision IDs, create
  dates) count as generated code.
- **Migrations and run-once scripts are not exempt, and need no exemption.**
  A migration or run-once script describes the change it makes. That is its
  contract, not history.
- **Tests follow the same rules**, with one addition: a regression test may
  name the issue it reproduces.

## The local half

Each repo's adoption record states:

- Where displaced content goes in that repo: the decision log, an issue
  closing comment, a commit message, or an additional artifact the repo
  declares.
- Any further exemptions, as logged deviations.

## Enforcement

Review only. The base ships no checker. A repo may add a grep check for date
patterns and the history words in rule 2 inside comments. If two repos write
their own, that is the evidence for adding one here.

Adoption does not require cleaning up existing comments at once. Clean up at
the repo's own pace, and apply the rules to every comment written or touched
from adoption onward.
