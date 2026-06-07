#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

init_test

out=$(run_bridge_and_assert "-h" 0 -h)
assert_stdout_contains "-h" "Usage: flat-bridge" "$out"
done_test "$out" "-h"
