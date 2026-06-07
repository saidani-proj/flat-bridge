#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

init_test

out=$(run_bridge_and_assert "unknown option" 0 --bogus)
assert_stdout_contains "unknown option" "Unknown option:" "$out"
done_test "$out" "unknown option"
