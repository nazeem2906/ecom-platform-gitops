#!/usr/bin/env bash
set -euo pipefail

REG_NAME="kind-registry"
REG_PORT="5001"

if [ "$(docker inspect -f '{{.State.Running}}' "${REG_NAME}" 2>/dev/null || true)" != "true" ]; then
  echo ">> Creating local registry ${REG_NAME} on 127.0.0.1:${REG_PORT}"
  docker run -d \
    --restart=always \
    -p "127.0.0.1:${REG_PORT}:5000" \
    --name "${REG_NAME}" \
    registry:2
else
  echo ">> Local registry ${REG_NAME} already running"
fi