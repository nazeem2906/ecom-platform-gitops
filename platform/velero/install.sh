#!/usr/bin/env bash
set -euo pipefail

echo ">> Installing Velero"
helm repo add vmware-tanzu https://vmware-tanzu.github.io/helm-charts >/dev/null 2>&1 || true
helm repo update

kubectl create namespace velero --dry-run=client -o yaml | kubectl apply -f -

helm upgrade --install velero vmware-tanzu/velero \
  -n velero \
  -f platform/backup/velero-values.yaml \
  --wait --timeout 10m

echo ">> Applying dedicated MinIO backend"
kubectl apply -f platform/backup/minio-manifest.yaml

echo ">> Velero status"
kubectl get pods -n velero
kubectl get backupstoragelocations -n velero
