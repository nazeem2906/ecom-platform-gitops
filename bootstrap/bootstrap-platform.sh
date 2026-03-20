#!/usr/bin/env bash
set -euo pipefail

echo ">> Applying namespaces and pod security labels"
kubectl apply -f bootstrap/namespaces/namespaces.yaml
kubectl apply -f bootstrap/namespaces/pod-security-labels.yaml

echo ">> Installing core platform components"
./platform/ingress-nginx/install.sh
./platform/metrics-server/install.sh
./platform/argocd/install.sh

echo ">> Installing platform add-ons"
./platform/cert-manager/install.sh
./platform/monitoring/install.sh
./platform/logging/install.sh
./platform/kyverno/install.sh
./platform/keda/install.sh
./platform/argo-rollouts/install.sh
./platform/velero/install.sh

echo ">> Platform bootstrap complete"
kubectl get ns
