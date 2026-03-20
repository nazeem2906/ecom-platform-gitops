#!/usr/bin/env bash
set -euo pipefail

echo ">> Installing Kyverno"
helm repo add kyverno https://kyverno.github.io/kyverno/ >/dev/null 2>&1 || true
helm repo update

helm upgrade --install kyverno kyverno/kyverno \
  -n kyverno \
  --create-namespace \
  --wait --timeout 10m

echo ">> Kyverno ready"
kubectl get pods -n kyverno
