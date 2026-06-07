#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

init_test
require_writable /usr/local/bin

out=$(run_bridge_and_assert "--user --system" 0 --user --system myapp)
assert_stdout_contains "--user --system" "/usr/local/bin/myapp" "$out"
done_test "$out" "--user --system (last wins)"
rm -f /usr/local/bin/myapp
