# Module: local development secrets

Opt-in, for code repos. This module states the rule only. The vault name,
the scope values and the naming of the items belong to a profile or the
repo's own adoption record.

Scope: local development only. Deployed environments get credentials from
whatever the deployment uses, not from this mechanism.

## Rule

A repo's `.env` never holds secret values. Secret keys hold secret references
that a secrets manager resolves at launch, and non-secret configuration
(hosts, ports, IDs, feature flags) stays a plain value. The examples below use
1Password, where `op run --env-file=.env -- <command>` resolves the
references.

- **Commit an example file** (`.env.example`) that shows the reference shape
  with no real values.
- **Never commit or keep a resolved copy** of `.env` anywhere in a repo.
  `.gitignore` covers `.env*` except the example file.
- **Reference items by title, never by opaque ID.** IDs are unreadable in
  review.
- **One item per secret, per scope.** Do not duplicate a shared secret into a
  repo-scoped item. Reference the shared item, so rotation happens once.
- **Rotating a secret edits the item**, and references do not change.
  Renaming an item or field breaks every `.env` that points at it, so search
  every repo's `.env*`, example files and READMEs first.

## Reference shape

```
op://<vault>/<item>/<field>
```

Recommended conventions, to be filled in by the profile or adoption record:

- **Vault:** one named vault for the repos covered.
- **Item title:** `<scope>-<system>[-<env>]`, lowercase, characters `a-z 0-9 -`
  only. Spaces, parentheses, slashes, underscores and capitals can make a
  reference invalid.
  - `<scope>` is `shared` when two or more repos use the item, otherwise the
    repo's short name.
  - `<env>` is `dev`, `stage` or `prod`, omitted when the system has a single
    environment.
  - Examples: `shared-mail-provider`, `shared-source-host`, `api-database-dev`.
- **Field names fixed by item type**, so a reference is predictable:
  - Tokens, API keys, session cookies and signing keys: `credential`.
  - Databases: `password`, with `username` and `database` alongside. Hostname
    and port are not secret and stay plain values in `.env`.
  - A system with several credentials may keep them as separate fields on one
    item, using these same names.
