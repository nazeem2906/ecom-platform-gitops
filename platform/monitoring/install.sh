#!/usr/bin/env bash
set -euo pipefail

echo ">> Ensuring monitoring namespace has privileged pod security labels"
kubectl label ns monitoring \
  pod-security.kubernetes.io/enforce=privileged \
  pod-security.kubernetes.io/audit=privileged \
  pod-security.kubernetes.io/warn=privileged \
  --overwrite

echo ">> Installing kube-prometheus-stack"
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts >/dev/null 2>&1 || true
helm repo update

helm upgrade --install kube-prometheus-stack prometheus-community/kube-prometheus-stack \
  -n monitoring \
  --create-namespace \
  -f platform/monitoring/kube-prometheus-values.yaml \
  --wait --timeout 10m

echo ">> Monitoring ready"
kubectl get pods -n monitoring
kubectl get ingress -n monitoring
