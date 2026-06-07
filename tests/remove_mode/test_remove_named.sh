#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

init_test

create_bridge -d "$TMPDIR" -n myalias myapp
assert_file_exists "$TMPDIR/myalias" "setup"

out=$(run_bridge_and_assert "-r named" 0 -r -d "$TMPDIR" myalias)
assert_stdout_contains "-r named" "Bridge removed at $TMPDIR/myalias" "$out"
assert_file_not_exists "$TMPDIR/myalias" "-r named"
done_test "$out" "-r removes named bridge (by name)"
