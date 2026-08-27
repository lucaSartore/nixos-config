#!/usr/bin/env bash
set -euo pipefail

region=false
edit=false

for arg in "$@"; do
  case "$arg" in
    -r|--region) region=true ;;
    -e|--edit) edit=true ;;
    -h|--help)
      echo "Usage: $(basename "$0") [-r|--region] [-e|--edit]"
      exit 0
      ;;
    *)
      echo "Unknown option: $arg" >&2
      exit 1
      ;;
  esac
done

mkdir -p ~/Pictures/Screenshots
FILE=~/Pictures/Screenshots/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png

# build the capture command
if $region; then
  geometry=$(slurp) || exit 1
  [ -z "$geometry" ] && exit 1  # selection cancelled
  capture_cmd=(grim -g "$geometry" -)
else
  capture_cmd=(grim -)
fi

# run it, branching on whether satty (edit mode) is wanted
if $edit; then
  "${capture_cmd[@]}" \
    | tee "$FILE" >(wl-copy --type image/png) \
    | satty -f -
else
  "${capture_cmd[@]}" \
    | tee "$FILE" \
    | wl-copy --type image/png
fi
