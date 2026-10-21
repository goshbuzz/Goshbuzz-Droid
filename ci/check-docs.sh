#!/usr/bin/env bash
# Verify relative Markdown links inside the repository resolve to real files.
# Usage: ci/check-docs.sh            (exit 0 = ok, exit 1 = broken links)
set -uo pipefail
cd "$(dirname "$0")/.." || exit 2

fail=0
while IFS= read -r -d '' file; do
  dir=$(dirname "$file")
  # Extract markdown link targets: ](target)
  grep -oE '\]\([^)]+\)' "$file" | sed -E 's/^\]\(//; s/\)$//' | while read -r target; do
    case "$target" in
      http://*|https://*|mailto:*|\#*|'') continue ;;
    esac
    # Strip anchors
    path=${target%%#*}
    [ -z "$path" ] && continue
    if [ ! -e "$dir/$path" ]; then
      printf 'BROKEN  %s -> %s\n' "$file" "$target"
      echo x >> /tmp/.goshbuzz_broken
    fi
  done
done < <(find . -path ./.git -prune -o -name '*.md' -print0)

if [ -f /tmp/.goshbuzz_broken ]; then
  count=$(wc -l < /tmp/.goshbuzz_broken)
  rm -f /tmp/.goshbuzz_broken
  echo "FAIL: $count broken link(s)"
  exit 1
fi
echo "OK: all relative markdown links resolve"
