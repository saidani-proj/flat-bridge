#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

init_test

out=$(run_bridge_and_assert "--help" 0 --help)
assert_stdout_contains "--help" "Usage: flat-bridge" "$out"
assert_stdout_contains "--help" "flatpak" "$out"
done_test "$out" "--help"
