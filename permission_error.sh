#!/bin/bash

FILE="/etc/test.conf"

echo "Checking permission for $FILE..."

if [ ! -e "$FILE" ]; then
    echo "ERROR: File does not exist."
    exit 1
fi

if [ -r "$FILE" ]; then
    echo "✓ File is readable."
else
    echo "✗ Permission denied: Cannot read $FILE"
    echo "DEBUG: Current user is $(whoami)"
    echo "DEBUG: File permissions:"
    ls -l "$FILE"
    
    if [ "$EUID" -ne 0 ]; then
        echo "SUGGESTION: Try running the script with sudo."
    fi
fi
