#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

init_test
export HOME="$TMPDIR/home"
mkdir -p "$HOME"

create_bridge myapp
assert_file_exists "$HOME/.local/bin/myapp" "setup"

out=$(run_bridge_and_assert "-r default" 0 -r myapp)
assert_stdout_contains "-r default" "Bridge removed at $HOME/.local/bin/myapp" "$out"
assert_file_not_exists "$HOME/.local/bin/myapp" "-r default"
done_test "$out" "-r defaults to user mode"
