#!/usr/bin/env bash

set -euo pipefail

SNAPSHOT_FILE=$1
WATCH_DIR="${2:-.}"

snapshot() {
  >&2 echo "Calculating snapshot..."
  find "$WATCH_DIR" -type d -print0 | sort -z | xargs -0 -n1 echo
  find "$WATCH_DIR" -type f -print0 | sort -z | xargs -0 sha1sum
  >&2 echo "Snapshot complete!"
}

date
CURRENT_SNAPSHOT=$(snapshot)

if [ -e "$SNAPSHOT_FILE" ]; then
  PREVIOUS_SNAPSHOT=$(cat "$SNAPSHOT_FILE")

  if [[ "$CURRENT_SNAPSHOT" != "$PREVIOUS_SNAPSHOT" ]]; then
    echo "Change(s) detected:"
    diff --color=always <(echo "$PREVIOUS_SNAPSHOT") <(echo "$CURRENT_SNAPSHOT") || true
  else
    echo "No changes."
  fi
else
  echo "No previous snapshot to compare"
fi

echo "$CURRENT_SNAPSHOT" > "$SNAPSHOT_FILE"
date
