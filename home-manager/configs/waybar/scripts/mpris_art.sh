#!/usr/bin/env bash
set -euo pipefail

SIZE=${1:-48}
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/waybar"
mkdir -p "$CACHE_DIR"

if ! playerctl -p spotify status >/dev/null 2>&1; then
  exit 0
fi
status=$(playerctl -p spotify status 2>/dev/null || echo "Stopped")
if [[ "$status" == "Stopped" ]]; then
  exit 0
fi

url=$(playerctl -p spotify metadata mpris:artUrl 2>/dev/null || true)
if [[ -z "$url" ]]; then
  exit 0
fi

if [[ "$url" =~ ^file:// ]]; then
  img_path="${url#file://}"
  echo "$img_path"
  exit 0
fi

hash=$(printf '%s' "$url" | sha256sum | cut -d' ' -f1)
img_path="$CACHE_DIR/$hash"
if [[ ! -f "$img_path" ]]; then
  curl -fsSL "$url" -o "$img_path.tmp" || exit 0
  mv "$img_path.tmp" "$img_path"
fi

if command -v convert >/dev/null 2>&1; then
  out="$CACHE_DIR/${hash}_${SIZE}.png"
  if [[ ! -f "$out" ]]; then
    convert "$img_path" -resize ${SIZE}x${SIZE} "$out" || cp "$img_path" "$out"
  fi
  echo "$out"
else
  echo "$img_path"
fi
