#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

init_test
export HOME="$TMPDIR/home"
mkdir -p "$HOME"

out=$(run_bridge_and_assert "default" 0 myapp)
assert_stdout_contains "default" "Bridge created at $HOME/.local/bin/myapp" "$out"
assert_file_executable "$HOME/.local/bin/myapp" "default"
done_test "$out" "default (user mode)"
