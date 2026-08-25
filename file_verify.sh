#!/bin/bash
# verify and open.sh - Simple username/password check before opening a file

VALID_USER="admin"
VALID_PASS="mypassword123"
TARGET_FILE="/path/to/secret_file.txt"

read -rp "Username: " input_user
read -rsp "Password: " input_pass
echo
if [[ "$input_user" == "$VALID_USER" && "$input_pass" == "$VALID_PASS" ]]; then
    echo "Access granted."
    cat "$TARGET_FILE"
else
    echo "Access denied: invalid username or password." >&2
    exit 1
fi
