#!/usr/bin/env bash
set -euo pipefail

player="spotify"

json_escape() {
  if command -v python3 >/dev/null 2>&1; then
    python3 - <<'PY'
import json,sys
print(json.dumps(sys.stdin.read()))
PY
  else
    awk 'BEGIN{ORS=""; print "\""} {gsub(/\\/,"\\\\"); gsub(/\"/,"\\\""); gsub(/\r/,""); gsub(/\n/,"\\n"); printf "%s", $0} END{print "\""}'
  fi
}

get_status() {
  playerctl -p "$player" status 2>/dev/null || echo "Stopped"
}

get_title() {
  playerctl -p "$player" metadata title 2>/dev/null || true
}

get_artist() {
  playerctl -p "$player" metadata artist 2>/dev/null || true
}

get_length_us() {
  playerctl -p "$player" metadata mpris:length 2>/dev/null || echo 0
}

get_position_s() {
  playerctl -p "$player" position 2>/dev/null || echo 0
}

format_time_s() {
  local total=${1:-0}
  total=${total%.*}
  local h=$(( total / 3600 ))
  local m=$(( (total % 3600) / 60 ))
  local s=$(( total % 60 ))
  if (( h > 0 )); then
    printf "%d:%02d:%02d" "$h" "$m" "$s"
  else
    printf "%02d:%02d" "$m" "$s"
  fi
}

while true; do
  status=$(get_status)
  title=$(get_title)
  artist=$(get_artist)
  length_us=$(get_length_us)
  position_s_raw=$(get_position_s)

  length_s=$(( length_us / 1000000 ))
  position_s=${position_s_raw%.*}

  pos_fmt=$(format_time_s "$position_s")
  len_fmt=$(format_time_s "$length_s")

  if [[ -n "${title}" || -n "${artist}" ]]; then
    text="<span weight=bold>${title}</span>\n${artist}  ${pos_fmt}:${len_fmt}"
  else
    text=""
  fi

  alt="${status,,}"

  printf '{"text":%s,"alt":%s,"tooltip":%s,"class":[%s]}' \
    "$(printf "%s" "$text" | json_escape)" \
    "$(printf "%s" "$alt" | json_escape)" \
    "$(printf "%s" "$title - $artist" | json_escape)" \
    "$(printf '"%s"' "$alt")"
  echo

  sleep 1

done
