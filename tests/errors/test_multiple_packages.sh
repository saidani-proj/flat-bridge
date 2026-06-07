#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

init_test

out=$(run_bridge_and_assert "multiple packages" 1 pkg1 pkg2)
assert_stdout_contains "multiple packages" "multiple package names" "$out"
done_test "$out" "multiple packages"
