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
"$BRIDGE" --branch=stable --arch=x86_64 -- --myarg value

LOG=$(cat "$MOCK_LOG")
EXPECTED="run --branch=stable --arch=x86_64 myapp --myarg value"
if [[ "$LOG" != "$EXPECTED" ]]; then
    fail "expected '$EXPECTED', got '$LOG'"
fi

echo "PASS: -- separator with flatpak options"
