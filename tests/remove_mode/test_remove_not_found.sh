#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

init_test

out=$(run_bridge_and_assert "-r not found" 1 -r -d "$TMPDIR" nonexistent)
assert_stdout_contains "-r not found" "no bridge found at $TMPDIR/nonexistent" "$out"
done_test "$out" "-r on missing bridge reports error"
