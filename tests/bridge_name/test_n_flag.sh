#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

init_test
export HOME="$TMPDIR/home"
mkdir -p "$HOME/.local/bin"

out=$(run_bridge_and_assert "-n <name>" 0 -n myalias myapp)
assert_stdout_contains "-n <name>" "Bridge created at $HOME/.local/bin/myalias" "$out"
assert_file_executable "$HOME/.local/bin/myalias" "-n"
done_test "$out" "-n <name>"
