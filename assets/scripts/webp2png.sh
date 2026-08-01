#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: webp2png <file.webp>" >&2
  exit 1
fi

input="$1"
output="${input%.webp}.png"

dwebp "$input" -o "$output"
echo "Converted: $output"
