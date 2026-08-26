#!/bin/bash
read -p "Directory: " dir
cd "$dir"
echo "1) Date  2) Name  3) Recently Used"
read -p "Choice: " c
for f in *; do
  [ "$c" == "1" ] && k=$(date -r "$f" +%Y-%m-%d)
  [ "$c" == "2" ] && k=$(echo "${f:0:1}" | tr a-z A-Z)
  [ "$c" == "3" ] && k=$(stat -c %x "$f" | cut -d' ' -f1)
  mkdir -p "$k"
  mv "$f" "$k"
done
