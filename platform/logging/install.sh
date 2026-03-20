#!/usr/bin/env bash
set -euo pipefail

echo ">> Installing Loki"
helm repo add grafana https://grafana.github.io/helm-charts >/dev/null 2>&1 || true
helm repo update

helm upgrade --install loki grafana/loki \
  -n logging \
  --create-namespace \
  -f platform/logging/loki-values.yaml \
  --wait --timeout 10m

echo ">> Installing Promtail"
helm upgrade --install promtail grafana/promtail \
  -n logging \
  --set "config.clients[0].url=http://loki-gateway.logging.svc.cluster.local/loki/api/v1/push" \
  --wait --timeout 10m

echo ">> Logging ready"
kubectl get pods -n logging
kubectl get svc -n logging
