#!/usr/bin/env bash
# Commit + push, wait for the GitHub build, flash the Totem.
#   ./update.sh        flash left half only (enough for keymap changes)
#   ./update.sh both   flash left, then right (needed after .conf/shield changes)
set -euo pipefail
cd "$(dirname "$0")"
repo=Otaroid/zmk-config-totem

if [ -n "$(git status --porcelain)" ]; then git add -A && git commit -qm "Update keymap"; fi
git push -q
sha=$(git rev-parse HEAD)

echo "Building ${sha:0:7} on GitHub..."
until id=$(gh run list -R "$repo" -c "$sha" -L1 --json databaseId -q '.[0].databaseId') && [ -n "$id" ]; do sleep 3; done
gh run watch "$id" -R "$repo" --exit-status >/dev/null ||
  { echo "Build failed. Log: gh run view $id -R $repo --log-failed"; exit 1; }
fw=$(mktemp -d)
gh run download "$id" -R "$repo" -D "$fw"

flash() {
  echo "Plug in the $1 half and double-press reset."
  until v=$(find /Volumes -maxdepth 1 -name 'XIAO*' | head -1) && [ -n "$v" ]; do sleep 1; done
  cp "$fw"/firmware/totem_"$1"-*.uf2 "$v/" 2>/dev/null || true # drive unmounts mid-copy, cp error is normal
  while [ -d "$v" ]; do sleep 1; done
  echo "$1 done."
}
flash left
if [ "${1:-}" = both ]; then flash right; fi
