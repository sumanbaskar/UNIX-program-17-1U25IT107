#!/bin/bash

set -u

SCRIPT="./starter/password_expiry.sh"
TEST_USER="assignment_test_user"

passed=0
failed=0

cleanup() {
    userdel "$TEST_USER" 2>/dev/null || true
}

trap cleanup EXIT

echo "======================================"
echo " Password Expiry Assignment Tests"
echo "======================================"

# Check starter script
if [[ ! -f "$SCRIPT" ]]; then
    echo "FAIL: $SCRIPT does not exist."
    exit 1
fi

chmod +x "$SCRIPT"

# Test 1: Missing username
if "$SCRIPT" >/dev/null 2>&1; then
    echo "FAIL: Script should reject a missing username."
    failed=$((failed + 1))
else
    echo "PASS: Missing username is rejected."
    passed=$((passed + 1))
fi

# Create temporary user
useradd -m "$TEST_USER"

# Test 2: Script executes
if "$SCRIPT" "$TEST_USER" >/tmp/password_expiry_output.txt 2>&1; then
    echo "PASS: Script executes successfully."
    passed=$((passed + 1))
else
    echo "FAIL: Script failed to execute."
    cat /tmp/password_expiry_output.txt
    failed=$((failed + 1))
fi

# Obtain chage information
CHAGE_OUTPUT=$(chage -l "$TEST_USER")

echo
echo "Password aging information:"
echo "$CHAGE_OUTPUT"
echo

# Test 3: Last password change
if echo "$CHAGE_OUTPUT" | grep -q "Last password change.*Jan 01, 2025"; then
    echo "PASS: Last password change is correct."
    passed=$((passed + 1))
else
    echo "FAIL: Last password change is incorrect."
    failed=$((failed + 1))
fi

# Test 4: Account expiration
if echo "$CHAGE_OUTPUT" | grep -q "Account expires.*Dec 31, 2026"; then
    echo "PASS: Account expiration date is correct."
    passed=$((passed + 1))
else
    echo "FAIL: Account expiration date is incorrect."
    failed=$((failed + 1))
fi

# Test 5: Minimum password age
if echo "$CHAGE_OUTPUT" | grep -q "Minimum number of days between password change.*7"; then
    echo "PASS: Minimum password age is 7 days."
    passed=$((passed + 1))
else
    echo "FAIL: Minimum password age is incorrect."
    failed=$((failed + 1))
fi

# Test 6: Maximum password age
if echo "$CHAGE_OUTPUT" | grep -q "Maximum number of days between password change.*90"; then
    echo "PASS: Maximum password age is 90 days."
    passed=$((passed + 1))
else
    echo "FAIL: Maximum password age is incorrect."
    failed=$((failed + 1))
fi

echo
echo "======================================"
echo "Passed: $passed"
echo "Failed: $failed"
echo "======================================"

if [[ "$failed" -eq 0 ]]; then
    exit 0
else
    exit 1
fi
