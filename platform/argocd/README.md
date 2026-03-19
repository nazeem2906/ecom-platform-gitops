# Argo CD

This directory contains the local Argo CD bootstrap for the kind cluster.

## Install

```bash
./platform/argocd/install.sh
kubectl apply -f platform/argocd/ingress.yaml
