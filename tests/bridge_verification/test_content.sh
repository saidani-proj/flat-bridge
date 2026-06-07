#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

init_test
mkdir -p "$TMPDIR/out"

create_bridge -d "$TMPDIR/out" -n vtest myapp
BRIDGE_FILE="$TMPDIR/out/vtest"
assert_file_exists "$BRIDGE_FILE" "bridge_content"

if ! grep -q 'exec flatpak run "myapp" "\$@"' "$BRIDGE_FILE"; then
    fail "wrong bridge content — got: $(cat "$BRIDGE_FILE")"
fi

done_test "" "bridge content"
