#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COUNT=0
while IFS= read -r -d '' f; do
  bash -n "$f"
  printf '[OK] %s\n' "${f#"$ROOT"/}"
  COUNT=$((COUNT + 1))
done < <(find "$ROOT" -name '*.sh' -type f -print0 | sort -z)
echo "[THANH CONG] Kiem tra cu phap $COUNT shell scripts."
