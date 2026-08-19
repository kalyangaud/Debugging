#!/bin/bash
# debug-browser.sh - diagnose why a browser won't open

echo " Default browser "
xdg-settings get default-web-browser 2>/dev/null || echo "xdg-settings not found"

echo " Installed browsers "
for b in firefox google-chrome chromium chromium-browser brave-browser;
do
    command -v "$b" &>/dev/null && echo "found: $(command -v $b)"
done

echo " Try launching with verbose output "
BROWSER=$(xdg-settings get default-web-browser 2>/dev/null | sed 's/.desktop//')
echo "Attempting: $BROWSER"
$BROWSER --version 2>&1

echo " xdg-open test "
xdg-open https://example.com 2>&1

echo " Check DISPLAY "
echo "DISPLAY=$DISPLAY"
echo "WAYLAND_DISPLAY=$WAYLAND_DISPLAY"

echo " Checking for crash logs "
dmesg | tail -20 | grep -i -E "segfault|browser" 
journalctl --user -xe -n 30 2>/dev/null | grep -i -E "browser|xdg"

echo " Permissions on browser binary "
ls -l "$(command -v $BROWSER 2>/dev/null)"
