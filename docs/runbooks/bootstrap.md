# Bootstrap Runbook

## Cluster creation

```bash
chmod +x bootstrap/kind/*.sh
./bootstrap/kind/create-cluster.sh

kubectl apply -f bootstrap/namespaces/namespaces.yaml
kubectl apply -f bootstrap/namespaces/pod-security-labels.yaml

chmod +x platform/ingress-nginx/install.sh
./platform/ingress-nginx/install.sh

kubectl apply -f tests/whoami/namespace.yaml
kubectl apply -f tests/whoami/deployment.yaml
kubectl apply -f tests/whoami/service.yaml
kubectl apply -f tests/whoami/ingress.yaml
curl -H 'Host: whoami.localhost' http://localhost:8080

