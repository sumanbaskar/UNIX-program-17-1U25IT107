#!/bin/bash

# Validate that a username was supplied
if [ -z "$1" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

USERNAME="$1"

# Configure password-aging settings
chage -d 2025-01-01 "$USERNAME"
chage -E 2026-12-31 "$USERNAME"
chage -m 7 "$USERNAME"
chage -M 90 "$USERNAME"

# Verify the resulting settings
chage -l "$USERNAME"
