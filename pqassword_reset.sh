#!/bin/bash
# reset_password.sh - Reset a local Linux user's password

set -euo pipefail
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root (use sudo)." >&2
    exit 1
fi

read -rp "Enter the username whose password you want to reset: " username

if ! id "$username" &>/dev/null; then
    echo "Error: user '$username' does not exist." >&2
    exit 1
fi

while true; do
    read -rsp "Enter new password: " password1
    echo
    read -rsp "Confirm new password: " password2
    echo

    if [[ "$password1" != "$password2" ]]; then
        echo "Passwords do not match. Try again."
        continue
    fi

    if [[ -z "$password1" ]]; then
        echo "Password cannot be empty. Try again."
        continue
    fi

    break
done

echo "${username}:${password1}" | chpasswd

if [[ $? -eq 0 ]]; then
    echo "Password for user '$username' has been reset successfully."
else
    echo "Failed to reset password." >&2
    exit 1
fi

read -rp "Force user to change password at next login? (y/n): " force_change
if [[ "$force_change" =~ ^[Yy]$ ]]; then
    chage -d 0 "$username"
    echo "User will be prompted to change password on next login."
fi
