#!/usr/bin/env bash
set -euo pipefail

find . \
  -not -path '*/.git/*' \
  -not -path '*/node_modules/*' \
  -not -path '*/.DS_Store' \
  | sort