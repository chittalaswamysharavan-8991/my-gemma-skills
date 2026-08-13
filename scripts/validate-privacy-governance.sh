#!/usr/bin/env bash
# Reject direct identifiers and private-context markers from the published
# legacy example. Keep this intentionally dependency-free so it can run in CI
# or a local shell.
set -euo pipefail

readonly TARGETS=("README.md" "SKILL.md")
readonly FORBIDDEN_PATTERN='pablo|sharavan|hyderabad|nanda|hyrox|salesforce|nandi|world of pablo|a\\.r\\. rahman|pedda cheruvu|notion'

for target in "${TARGETS[@]}"; do
  if [[ ! -f "$target" ]]; then
    printf 'privacy/governance validation failed: missing required file: %s\n' "$target" >&2
    exit 1
  fi
done

if grep --line-number --ignore-case --extended-regexp "$FORBIDDEN_PATTERN" "${TARGETS[@]}"; then
  printf '%s\n' 'privacy/governance validation failed: personal or private context detected.' >&2
  exit 1
fi

if ! grep --quiet --fixed-strings 'legacy, non-canonical' README.md SKILL.md; then
  printf '%s\n' 'privacy/governance validation failed: legacy/non-canonical status is missing.' >&2
  exit 1
fi

if ! grep --quiet --fixed-strings '/SharvaOS/CHATGPT.md' README.md SKILL.md; then
  printf '%s\n' 'privacy/governance validation failed: Sharva authority notice is missing.' >&2
  exit 1
fi

printf '%s\n' 'privacy/governance validation passed.'
