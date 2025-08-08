#!/usr/bin/env bash
set -euo pipefail
player=spotify
playerctl -p "$player" metadata title 2>/dev/null || true
