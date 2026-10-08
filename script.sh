#!/bin/bash

user="testuser"

if ! id "$user" >/dev/null 2>&1; then
    sudo useradd "$user"
fi

sudo chage -d 2025-01-01 "$user"
sudo chage -E 2026-12-31 "$user"
sudo chage -m 7 "$user"
sudo chage -M 90 "$user"
