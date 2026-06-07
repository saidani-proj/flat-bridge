#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

init_test
CUSTOM_DIR="$TMPDIR/custom"
mkdir -p "$CUSTOM_DIR"

out=$(run_bridge_and_assert "--bin-dir <path>" 0 --bin-dir "$CUSTOM_DIR" myapp)
assert_stdout_contains "--bin-dir <path>" "Bridge created at $CUSTOM_DIR/myapp" "$out"
assert_file_executable "$CUSTOM_DIR/myapp" "--bin-dir"
done_test "$out" "--bin-dir <path>"
