#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

chage -d 2025-01-01 "$1"
chage -E 2026-12-31 "$1"
chage -m 7 "$1"
chage -M 90 "$1"
