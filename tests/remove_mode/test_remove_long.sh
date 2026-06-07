#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

init_test

create_bridge -d "$TMPDIR" myapp
assert_file_exists "$TMPDIR/myapp" "setup"

out=$(run_bridge_and_assert "--remove" 0 --remove -d "$TMPDIR" myapp)
assert_stdout_contains "--remove" "Bridge removed at $TMPDIR/myapp" "$out"
assert_file_not_exists "$TMPDIR/myapp" "--remove"
done_test "$out" "--remove removes bridge"
