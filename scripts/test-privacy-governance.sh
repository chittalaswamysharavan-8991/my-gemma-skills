#!/usr/bin/env bash
# Exercise the validator against the sanitized repository and a representative
# forbidden marker without modifying the working tree.
set -euo pipefail

readonly REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
readonly VALIDATOR="$REPO_ROOT/scripts/validate-privacy-governance.sh"
readonly TEST_ROOT="$(mktemp -d)"
trap 'rm -rf "$TEST_ROOT"' EXIT

bash "$VALIDATOR"

mkdir -p "$TEST_ROOT/scripts"
cp "$REPO_ROOT/README.md" "$REPO_ROOT/SKILL.md" "$TEST_ROOT/"
cp "$VALIDATOR" "$TEST_ROOT/scripts/validate-privacy-governance.sh"

printf '\nA.R. Rahman\n' >> "$TEST_ROOT/SKILL.md"

set +e
(
  cd "$TEST_ROOT"
  bash scripts/validate-privacy-governance.sh >/dev/null 2>&1
)
readonly VALIDATION_STATUS=$?
set -e

if [[ "$VALIDATION_STATUS" -ne 1 ]]; then
  printf 'privacy/governance test failed: representative marker was not rejected.\n' >&2
  exit 1
fi

printf 'privacy/governance focused test passed.\n'
