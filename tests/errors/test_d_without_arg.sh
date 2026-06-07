#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

init_test

out=$(run_bridge_and_assert "-d without argument" 1 -d)
assert_stdout_contains "-d without argument" "--bin-dir requires an argument" "$out"
done_test "$out" "-d without argument"
