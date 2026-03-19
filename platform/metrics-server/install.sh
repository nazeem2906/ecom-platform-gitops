#!/usr/bin/env bash
set -euo pipefail

echo ">> Installing metrics-server"
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

echo ">> Patching metrics-server for local kind"
kubectl patch deployment metrics-server \
  -n kube-system \
  --type='json' \
  -p='[
    {
      "op": "add",
      "path": "/spec/template/spec/containers/0/args/-",
      "value": "--kubelet-insecure-tls"
    }
  ]'

echo ">> Waiting for metrics-server rollout"
kubectl rollout status deployment/metrics-server -n kube-system --timeout=180s

echo ">> metrics-server ready"
kubectl top nodes || true