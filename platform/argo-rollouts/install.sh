#!/usr/bin/env bash
set -euo pipefail

echo ">> Installing Argo Rollouts"
kubectl create namespace argo-rollouts --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml

echo ">> Adjusting controller resources for local kind lab"
kubectl set resources deployment/argo-rollouts -n argo-rollouts \
  --requests=cpu=25m,memory=64Mi \
  --limits=cpu=100m,memory=128Mi

kubectl rollout restart deployment/argo-rollouts -n argo-rollouts

echo ">> Argo Rollouts status"
kubectl get pods -n argo-rollouts
