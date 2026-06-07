# shellcheck shell=bash
# flat-bridge test helpers — source, don't execute directly

BRIDGE_SCRIPT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/src/flat-bridge"

TMPDIR=""

fail() { echo "FAIL: $*" >&2; exit 1; }

# --- Test lifecycle ---

init_test() {
    TMPDIR=$(mktemp -d /tmp/flat-bridge-test-XXXXXX)
    trap 'rm -rf "$TMPDIR"' EXIT
}

done_test() {
    local outfile="${1:-}" label="${2:-}"
    [[ -n "$outfile" ]] && cleanup_file "$outfile"
    if [[ -n "$label" ]]; then
        echo "PASS: $label"
    else
        echo "PASS"
    fi
}

# --- File assertions ---

assert_file_exists() {
    local path="$1" label="${2:-file_exists}"
    [[ -f "$path" ]] || fail "$label: expected file '$path' not found"
}

assert_file_not_exists() {
    local path="$1" label="${2:-file_not_exists}"
    [[ ! -f "$path" ]] || fail "$label: file '$path' still exists"
}

assert_file_executable() {
    local path="$1" label="${2:-file_executable}"
    [[ -x "$path" ]] || fail "$label: file '$path' is not executable"
}

# --- Bridge helpers ---

create_bridge() {
    bash "$BRIDGE_SCRIPT" "$@" > /dev/null 2>&1
}

# --- Permission helpers ---

require_writable() {
    local dir="$1" probe
    probe="$dir/.flat-bridge-probe-$$"
    if ! touch "$probe" 2>/dev/null; then
        echo "SKIP: no write permission for $dir"
        exit 0
    fi
    rm -f "$probe"
}

# --- Output assertions ---

assert_exit_code() {
    local expected=$1 label="$2" outfile="$3"
    local actual
    actual=$(cat "$outfile.exit")
    if [[ "$actual" != "$expected" ]]; then
        fail "$label: expected exit $expected, got $actual"
    fi
}

assert_stdout_contains() {
    local label="$1" needle="$2" outfile="$3"
    if ! grep -Fq -- "$needle" "$outfile.stdout"; then
        fail "$label: stdout missing '$needle' (got: $(cat "$outfile.stdout"))"
    fi
}

assert_stdout_not_contains() {
    local label="$1" needle="$2" outfile="$3"
    if grep -Fq -- "$needle" "$outfile.stdout"; then
        fail "$label: stdout unexpectedly contains '$needle'"
    fi
}

# --- Test execution ---

run_bridge() {
    local label="$1" outfile
    outfile=$(mktemp /tmp/flat-bridge-test-XXXXXX)
    shift
    bash "$BRIDGE_SCRIPT" "$@" > "$outfile.stdout" 2> "$outfile.stderr" && rc=$? || rc=$?
    echo "$rc" > "$outfile.exit"
    echo "$outfile"
}

run_bridge_and_assert() {
    local label="$1" expected_exit="$2"
    shift 2
    local outfile
    outfile=$(run_bridge "$label" "$@")
    assert_exit_code "$expected_exit" "$label" "$outfile"
    echo "$outfile"
}

cleanup_file() { rm -f "$1.stdout" "$1.stderr" "$1.exit" "$1"; }
