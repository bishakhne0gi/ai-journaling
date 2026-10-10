#!/usr/bin/env bash
# Fails when kit branding or an Anthropic key is tracked. The repo is public.
set -euo pipefail
cd "$(dirname "$0")/.."

pattern='razorpay|raz-prep|razor|interview|sk-ant-[A-Za-z0-9_-]{10,}'
matches="$(git ls-files -z -- . ':(exclude)docs/superpowers' ':(exclude)scripts/check-hygiene.sh' \
  | xargs -0 grep -nIiE "$pattern" -- 2>/dev/null || true)"

if [ -n "$matches" ]; then
  echo "$matches" >&2
  echo "hygiene: forbidden wording or secret found" >&2
  exit 1
fi
echo "hygiene: clean"
