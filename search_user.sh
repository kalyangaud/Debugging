#!/bin/bash

# search_user.sh - Search for users by name or userid
USERFILE="/etc/passwd"

usage() {
    echo "Usage: $0 -n <name> | -i <userid>"
    echo "  -n  Search by username"
    echo "  -i  Search by user ID"
    exit 1
}

search_by_name() {
    local name="$1"
    echo "Searching for users matching name: $name"
    result=$(grep -i "^[^:]*$name" "$USERFILE" | awk -F: '{print "Username: "$1", UID: "$3", Home: "$6}')
    if [ -z "$result" ]; then
        echo "No users found matching '$name'"
    else
        echo "$result"
    fi
}

search_by_id() {
    local uid="$1"
    echo "Searching for user with UID: $uid"
    echo "----------------------------------------"
    result=$(awk -F: -v id="$uid" '$3 == id {print "Username: "$1", UID: "$3", Home: "$6}' "$USERFILE")

    if [ -z "$result" ]; then
        echo "No user found with UID '$uid'"
    else
        echo "$result"
    fi
}

while getopts "n:i:h" opt; do
    case $opt in
        n) search_by_name "$OPTARG" ;;
        i) search_by_id "$OPTARG" ;;
        h) usage ;;
        *) usage ;;
    esac
done
