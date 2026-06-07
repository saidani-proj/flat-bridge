#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

init_test

create_bridge -d "$TMPDIR" myapp
assert_file_exists "$TMPDIR/myapp" "setup"

chmod -w "$TMPDIR"

out=$(run_bridge "-r locked dir" -r -d "$TMPDIR" myapp)
assert_exit_code 1 "-r locked dir" "$out"
assert_stdout_not_contains "-r locked dir" "Bridge removed" "$out"
assert_file_exists "$TMPDIR/myapp" "-r locked dir"

chmod +w "$TMPDIR"

done_test "$out" "-r on locked directory fails"
