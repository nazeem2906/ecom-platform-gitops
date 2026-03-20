#!/usr/bin/env bash
set -euo pipefail

echo ">> Installing cert-manager"
helm upgrade --install cert-manager oci://quay.io/jetstack/charts/cert-manager \
  -n cert-manager \
  --create-namespace \
  --set installCRDs=true \
  --wait --timeout 10m

echo ">> Applying self-signed ClusterIssuer"
kubectl apply -f platform/cert-manager/selfsigned-clusterissuer.yaml

echo ">> cert-manager ready"
kubectl get pods -n cert-manager
kubectl get clusterissuer
