#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

init_test
mkdir -p "$TMPDIR/out"

create_bridge -d "$TMPDIR/out" -n ptest myapp
BRIDGE_FILE="$TMPDIR/out/ptest"
assert_file_exists "$BRIDGE_FILE" "bridge_permissions"
assert_file_executable "$BRIDGE_FILE" "bridge_permissions"

done_test "" "bridge permissions"
