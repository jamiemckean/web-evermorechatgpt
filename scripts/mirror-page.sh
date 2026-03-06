#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <url> [url ...]"
  echo "Example: $0 https://evermore.co/ https://evermore.co/what-we-do/"
  exit 1
fi

OUT_DIR="site-mirror"
DOMAINS="evermore.co,www.evermore.co,cdn.jsdelivr.net,fonts.googleapis.com,fonts.gstatic.com,s.w.org"

mkdir -p "$OUT_DIR"

for url in "$@"; do
  echo "Mirroring: $url"
  wget \
    --continue \
    --execute robots=off \
    --page-requisites \
    --adjust-extension \
    --convert-links \
    --span-hosts \
    --domains "$DOMAINS" \
    --directory-prefix "$OUT_DIR" \
    "$url" || rc=$?

  # wget uses exit code 8 for common mirror-time HTTP issues (404/400 on some assets).
  # Keep going unless the error is a different hard failure.
  if [ "${rc:-0}" -ne 0 ] && [ "${rc:-0}" -ne 8 ]; then
    echo "wget failed for $url with exit code ${rc}" >&2
    exit "${rc}"
  fi
  unset rc
done

echo

echo "Done. Local mirror saved under: $OUT_DIR"
echo "Preview with: python3 -m http.server 4173 --directory $OUT_DIR"
