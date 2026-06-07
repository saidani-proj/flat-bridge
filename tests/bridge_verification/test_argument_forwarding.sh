#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

init_test

MOCK_LOG="$TMPDIR/mock.log"
: > "$MOCK_LOG"
cat > "$TMPDIR/flatpak" <<MOCK
#!/usr/bin/env bash
echo "\$@" >> "$MOCK_LOG"
MOCK
chmod +x "$TMPDIR/flatpak"
export PATH="$TMPDIR:$PATH"
export MOCK_LOG

create_bridge -d "$TMPDIR/bin" -n myapp myapp
BRIDGE="$TMPDIR/bin/myapp"
assert_file_exists "$BRIDGE" "bridge_created"

: > "$MOCK_LOG"
"$BRIDGE" --some-flag --another arg1 arg2
LOG=$(cat "$MOCK_LOG")
EXPECTED="run myapp --some-flag --another arg1 arg2"
if [[ "$LOG" != "$EXPECTED" ]]; then
    fail "without --: expected '$EXPECTED', got '$LOG'"
fi

: > "$MOCK_LOG"
"$BRIDGE" --branch=stable -- --myapp-flag arg
LOG=$(cat "$MOCK_LOG")
EXPECTED="run --branch=stable myapp --myapp-flag arg"
if [[ "$LOG" != "$EXPECTED" ]]; then
    fail "with --: expected '$EXPECTED', got '$LOG'"
fi

: > "$MOCK_LOG"
"$BRIDGE" -- --app-arg
LOG=$(cat "$MOCK_LOG")
EXPECTED="run myapp --app-arg"
if [[ "$LOG" != "$EXPECTED" ]]; then
    fail "-- only: expected '$EXPECTED', got '$LOG'"
fi

: > "$MOCK_LOG"
"$BRIDGE" --branch=stable --devel --
LOG=$(cat "$MOCK_LOG")
EXPECTED="run --branch=stable --devel myapp"
if [[ "$LOG" != "$EXPECTED" ]]; then
    fail "opts only: expected '$EXPECTED', got '$LOG'"
fi

echo "PASS: argument forwarding"
