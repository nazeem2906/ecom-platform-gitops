#!/usr/bin/env bash
set -euo pipefail

echo ">> Installing ingress-nginx"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

echo ">> Waiting for ingress controller"
kubectl wait \
  --namespace ingress-nginx \
  --for=condition=Ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=180s

echo ">> ingress-nginx ready"
kubectl get pods -n ingress-nginx