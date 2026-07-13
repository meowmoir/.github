#!/usr/bin/env bash
#
# Bootstrap the Meowmoir workspace root.
#
# Writes the one-line shim `justfile` at the workspace root so `just` finds the
# canonical orchestrator in this repo (.github/workspace/justfile). Run once
# after cloning the meowmoir-* repos and the .github repo into a shared parent:
#
#     ./.github/workspace/bootstrap.sh
#
# Idempotent: re-running is a no-op when the shim is already in place. If a
# different justfile already exists at the root, it is backed up rather than
# clobbered.
set -euo pipefail

# Workspace root is two levels up from this script (.github/workspace/).
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
workspace_root="$(cd "$script_dir/../.." && pwd)"
root_justfile="$workspace_root/justfile"

# The shim's exact contents — kept byte-for-byte in sync with the README.
# Command substitution strips the trailing newline; `printf '%s\n'` re-adds
# exactly one when writing, so the file stays single-newline-terminated.
shim="$(cat <<'EOF'
# Meowmoir workspace orchestrator — recipes live in the org `.github` repo.
# See .github/workspace/README.md.
import '.github/workspace/justfile'
EOF
)"

# Sanity check: the canonical justfile must sit next to this script, otherwise
# the shim would import a path that doesn't exist.
if [[ ! -f "$script_dir/justfile" ]]; then
    echo "error: canonical justfile not found at $script_dir/justfile" >&2
    echo "       run this from a real .github checkout inside the workspace." >&2
    exit 1
fi

if [[ -f "$root_justfile" ]]; then
    if [[ "$(cat "$root_justfile")" == "$shim" ]]; then
        echo "ok: workspace already bootstrapped ($root_justfile)"
        exit 0
    fi
    backup="$root_justfile.bak"
    echo "warning: $root_justfile exists with different contents" >&2
    echo "         backing it up to $backup before overwriting" >&2
    cp "$root_justfile" "$backup"
fi

printf '%s\n' "$shim" > "$root_justfile"
echo "wrote $root_justfile"

if ! command -v just >/dev/null 2>&1; then
    echo "note: 'just' is not installed — see https://github.com/casey/just" >&2
fi

echo "done. run: (cd '$workspace_root' && just)"
