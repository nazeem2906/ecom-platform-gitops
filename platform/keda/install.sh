#!/usr/bin/env bash
set -euo pipefail

echo ">> Installing KEDA"
helm repo add kedacore https://kedacore.github.io/charts >/dev/null 2>&1 || true
helm repo update

helm upgrade --install keda kedacore/keda \
  -n keda \
  --create-namespace \
  --wait --timeout 10m

echo ">> KEDA ready"
kubectl get pods -n keda
