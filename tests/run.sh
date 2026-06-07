#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
PASS=0
FAIL=0
RESULTS=""

run_test() {
    local file="$1" relpath
    relpath="${file#$ROOT/}"
    echo -n "  $relpath ... "

    if output=$(bash "$file" 2>&1); then
        echo "PASS"
        PASS=$((PASS+1))
    else
        echo "FAIL"
        echo "$output" | sed 's/^/      /'
        FAIL=$((FAIL+1))
    fi
}

echo "flat-bridge tests"
echo ""

for group_dir in "$ROOT"/*/; do
    group=$(basename "$group_dir")
    [[ "$group" == "run.sh" || "$group" == "lib.sh" ]] && continue
    echo "[$group]"
    for test_file in "$group_dir"test_*.sh; do
        [[ -f "$test_file" ]] || continue
        run_test "$test_file"
    done
    echo ""
done

echo "=== results: $PASS passed, $FAIL failed ==="
[[ $FAIL -eq 0 ]]
