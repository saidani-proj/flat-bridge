#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

init_test
CUSTOM_DIR="$TMPDIR/custom"
mkdir -p "$CUSTOM_DIR"

out=$(run_bridge_and_assert "-d <path>" 0 -d "$CUSTOM_DIR" myapp)
assert_stdout_contains "-d <path>" "Bridge created at $CUSTOM_DIR/myapp" "$out"
assert_file_executable "$CUSTOM_DIR/myapp" "-d"
done_test "$out" "-d <path>"
