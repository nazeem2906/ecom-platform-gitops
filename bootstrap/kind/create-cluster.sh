#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="ecom-platform"
REG_NAME="kind-registry"
REG_PORT="5001"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="${SCRIPT_DIR}/kind-config.yaml"

echo ">> Ensuring local registry exists"
"${SCRIPT_DIR}/local-registry.sh"

if kind get clusters | grep -q "^${CLUSTER_NAME}$"; then
  echo ">> Cluster ${CLUSTER_NAME} already exists"
else
  echo ">> Creating kind cluster ${CLUSTER_NAME}"
  kind create cluster --name "${CLUSTER_NAME}" --config "${CONFIG_FILE}"
fi

echo ">> Connecting registry to kind network if needed"
if [ "$(docker inspect -f '{{json .NetworkSettings.Networks.kind}}' "${REG_NAME}")" = "null" ]; then
  docker network connect "kind" "${REG_NAME}"
fi

echo ">> Publishing local registry information inside cluster"
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: local-registry-hosting
  namespace: kube-public
data:
  localRegistryHosting.v1: |
    host: "localhost:${REG_PORT}"
    help: "https://kind.sigs.k8s.io/docs/user/local-registry/"
EOF

echo ">> Waiting for node readiness"
kubectl wait --for=condition=Ready node/"${CLUSTER_NAME}-control-plane" --timeout=120s

echo
echo ">> Cluster ready"
echo "Ingress HTTP  : http://localhost:8080"
echo "Ingress HTTPS : https://localhost:8443"
echo "Registry      : localhost:${REG_PORT}"