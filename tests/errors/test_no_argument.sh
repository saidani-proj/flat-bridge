#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

init_test

out=$(run_bridge_and_assert "no argument" 0)
assert_stdout_contains "no argument" "package name is required" "$out"
done_test "$out" "no argument"
