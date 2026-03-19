#!/usr/bin/env bash
set -euo pipefail

echo ">> Installing Argo CD in namespace argocd"
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo ">> Waiting for Argo CD server deployment rollout"
kubectl rollout status deployment/argocd-server -n argocd --timeout=300s

echo ">> Argo CD installed"
kubectl get pods -n argocd
