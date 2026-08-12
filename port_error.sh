#!/bin/bash

FILE="/etc/test.conf"
echo "<<<<<<<PERMISSION DEBUGGER>>>>>>"

echo "Checking: $FILE"
echo
if [ ! -e "$FILE" ]; then
    echo "✗ ERROR: File does not exist."
    exit 1
fi
echo "File information:"
ls -l "$FILE"
echo
echo "Current user: $(whoami)"
echo "User ID: $EUID"
echo
if [ -r "$FILE" ]; then
    echo "✓ READ permission: OK"
else
    echo "✗ READ permission: DENIED"
fi
if [ -w "$FILE" ]; then
    echo "✓ WRITE permission: OK"
else
    echo "✗ WRITE permission: DENIED"
fi
if [ -x "$FILE" ]; then
    echo "✓ EXECUTE permission: OK"
else
    echo "✗ EXECUTE permission: DENIED"
fi
echo ".......DEBUG INFORMATION......"
OWNER=$(stat -c "%U" "$FILE")
GROUP=$(stat -c "%G" "$FILE")
PERMS=$(stat -c "%A" "$FILE")

echo "Owner       : $OWNER"
echo "Group       : $GROUP"
echo "Permissions : $PERMS"

echo
if [ "$EUID" -eq 0 ]; then
    echo "✓ Script is running as root."
else
    echo "⚠ Script is NOT running as root."
fi

echo
if [ ! -r "$FILE" ] || [ ! -w "$FILE" ]; then
    echo "Possible solution:"
    echo "  1. Check file ownership"
    echo "  2. Check file permissions"
    echo "  3. Use sudo if appropriate"
    echo "  4. Avoid blindly using chmod 777"
fi

echo "........DEBUGGING COMPLETE...... "
