#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

init_test
require_writable /usr/local/bin

out=$(run_bridge_and_assert "--system" 0 --system myapp)
assert_stdout_contains "--system" "Bridge created at /usr/local/bin/myapp" "$out"
done_test "$out" "--system"
rm -f /usr/local/bin/myapp
