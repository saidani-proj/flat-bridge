#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

init_test
COMBO_DIR="$TMPDIR/combo"
mkdir -p "$COMBO_DIR"

out=$(run_bridge_and_assert "-d + -n" 0 -d "$COMBO_DIR" -n alias2 myapp)
assert_stdout_contains "-d + -n" "Bridge created at $COMBO_DIR/alias2" "$out"
assert_file_executable "$COMBO_DIR/alias2" "-d + -n"
done_test "$out" "-d + -n"
