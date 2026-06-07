#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

init_test
require_writable /usr/local/bin

create_bridge --system myapp

out=$(run_bridge_and_assert "-r --system" 0 -r --system myapp)
assert_stdout_contains "-r --system" "Bridge removed at /usr/local/bin/myapp" "$out"
done_test "$out" "-r --system"
