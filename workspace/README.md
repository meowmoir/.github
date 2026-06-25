# Workspace orchestrator

`justfile` here is the **workspace-level** dev orchestrator for Meowmoir. It
forwards to each repo's own justfile and adds cross-repo helpers (`just dev`,
`just test`, …). It runs from the **workspace root**: the directory that holds
the `meowmoir-*` repos and this `.github` checkout.

It lives here (in the org `.github` repo) so it's the single, tracked source of
truth — the per-repo justfiles stay each repo's own concern.

## Setup

Put a one-line `justfile` at the workspace root that imports this one:

```sh
cd <workspace-root>   # the dir holding meowmoir-backend, meowmoir-ios, .github, …
printf "import '.github/workspace/justfile'\n" > justfile
```

The root shim is local-only (the workspace root isn't a git repo); the recipes
it imports are tracked here.

## Recipes

| Recipe | What |
|---|---|
| `just dev` | Start the backend in the background + launch the iOS app — one command |
| `just stop` | Stop the background dev backend |
| `just test` | Run the backend + iOS test suites |
| `just backend <r>` | Forward to `meowmoir-backend`'s justfile, e.g. `just backend migrate` |
| `just ios <r>` | Forward to `meowmoir-ios`'s justfile, e.g. `just ios run` |
| `just docs <r>` | Forward to `meowmoir-docs`'s justfile, e.g. `just docs serve` |

The AI steps in the iOS app need the dev backend; `just dev` starts it for you,
or run `just backend serve` yourself. The app targets `http://127.0.0.1:8000`
(IPv4) so the simulator doesn't hit an IPv6 listener on the same port.
