# `.github`

Organization-level defaults for [meowmoir](https://github.com/meowmoir).

- **`profile/README.md`** — the public org profile, rendered at <https://github.com/meowmoir>.
- **Community health defaults** — `CONTRIBUTING.md`, `SECURITY.md`, and the issue / PR templates
  apply to **every repo in the org** that doesn't define its own.
- **`.github/workflows/`** — reusable workflows other repos can call, e.g.
  `uses: meowmoir/.github/.github/workflows/secret-scan.yml@main`.

> This repo must stay **public** for the profile and default templates to take effect.
