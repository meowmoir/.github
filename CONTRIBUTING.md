# Contributing

Conventions shared across all Meowmoir repos. Per-repo `CONTRIBUTING.md` overrides this.

## Workflow

- Work on **feature branches**; open a PR even when solo (keeps a CI gate + history). Never
  force-push `main`.
- **One logical change per commit.** Commit messages in **English**, imperative mood, ≤ 72 chars.
- Run the repo's linter / build before committing.

## Code

- **English** for identifiers, comments, and commit messages.
- One concept per file; keep modules focused; handle errors explicitly.
- Match the existing style of the repo you're in — read before you write.

## Secrets

- Never commit secrets, API keys, signing certs/profiles, or `.env` files. Secret-scanning runs in
  CI (see [`secret-scan.yml`](.github/workflows/secret-scan.yml)).
