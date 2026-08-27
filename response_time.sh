#!/bin/bash
# Simple server response time checker

URL="${1:-http://localhost}"

echo "Checking: $URL"
curl -o /dev/null -s -w "Connect: %{time_connect}s | Total: %{time_total}s | Code: %{http_code}\n" "$URL"

echo -e "Top CPU/Memory usage:"
ps -eo pid,cmd,%cpu,%mem --sort=-%cpu | head -5

echo -e "Load average:"
uptime
