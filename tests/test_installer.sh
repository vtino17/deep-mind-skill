#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."
export DEEP_MIND_LIB_ONLY=1
source ./install.sh

test_root="$(mktemp -d)"
trap 'find "$test_root" -type f -delete; find "$test_root" -depth -type d -empty -delete' EXIT

install_skill custom "Test Agent" "$test_root/managed" >/dev/null
[[ -f "$test_root/managed/skills/deep-mind/.deep-mind-managed" ]]

mkdir -p "$test_root/foreign/skills/deep-mind"
printf 'user content\n' > "$test_root/foreign/skills/deep-mind/SKILL.md"
if install_skill custom "Foreign Agent" "$test_root/foreign" >/dev/null 2>&1; then
  echo "installer overwrote an unmanaged skill" >&2
  exit 1
fi
grep -q 'user content' "$test_root/foreign/skills/deep-mind/SKILL.md"

if uninstall_skill custom "Foreign Agent" "$test_root/foreign" >/dev/null 2>&1; then
  echo "installer removed an unmanaged skill" >&2
  exit 1
fi
[[ -f "$test_root/foreign/skills/deep-mind/SKILL.md" ]]
