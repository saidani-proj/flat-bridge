#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

init_test
export HOME="$TMPDIR/home"
mkdir -p "$HOME"

out=$(run_bridge_and_assert "--user" 0 --user myapp)
assert_stdout_contains "--user" "Bridge created at $HOME/.local/bin/myapp" "$out"
assert_file_executable "$HOME/.local/bin/myapp" "--user"
done_test "$out" "--user"
