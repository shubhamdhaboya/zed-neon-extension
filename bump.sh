#!/usr/bin/env bash
#
# bump.sh — rebuild + test the tree-sitter-neon grammar, commit it, and point
# this extension's `rev` at the new commit. Run after editing grammar.js.
#
#   ./bump.sh "support datetime literals"
#
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GRAMMAR="$(cd "$HERE/../tree-sitter-neon" && pwd)"
EXT_TOML="$HERE/extension.toml"
MSG="${1:-update grammar}"

echo "==> tree-sitter generate + test"
( cd "$GRAMMAR" && tree-sitter generate && tree-sitter test )

echo "==> commit grammar (if changed)"
(
  cd "$GRAMMAR"
  git add -A
  if git diff --cached --quiet; then
    echo "    no changes to commit"
  else
    git commit -q -m "$MSG"
  fi
)

SHA="$(cd "$GRAMMAR" && git rev-parse HEAD)"
echo "==> grammar HEAD: $SHA"

echo "==> updating rev in extension.toml"
# Only the active (uncommented) rev line; the commented publish block is left alone.
sed -i '' -E "s|^rev = \".*\"|rev = \"$SHA\"|" "$EXT_TOML"

echo "==> done. In Zed: run 'zed: reload extensions'"
