#!/bin/bash

# Validate username
if [ -z "$1" ]; then
    echo "Error: Username is required."
    exit 1
fi

USERNAME="$1"

# Configure password-aging settings
chage -d 2025-01-01 "$USERNAME"
chage -E 2026-12-31 "$USERNAME"
chage -m 7 "$USERNAME"
chage -M 90 "$USERNAME"

echo "Password expiry settings configured for $USERNAME."
