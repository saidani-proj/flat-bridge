#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

init_test
COMBO_DIR="$TMPDIR/combo"
mkdir -p "$COMBO_DIR"

out=$(run_bridge_and_assert "-n + -d" 0 -n alias1 -d "$COMBO_DIR" myapp)
assert_stdout_contains "-n + -d" "Bridge created at $COMBO_DIR/alias1" "$out"
assert_file_executable "$COMBO_DIR/alias1" "-n + -d"
done_test "$out" "-n + -d"
