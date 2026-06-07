#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

init_test

out=$(run_bridge_and_assert "--name without argument" 1 -n)
assert_stdout_contains "--name without argument" "--name requires an argument" "$out"
done_test "$out" "--name without argument"
