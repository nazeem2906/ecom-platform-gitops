# whoami test

Simple ingress validation app.

## Deploy

```bash
kubectl apply -f tests/whoami/namespace.yaml
kubectl apply -f tests/whoami/deployment.yaml
kubectl apply -f tests/whoami/service.yaml
kubectl apply -f tests/whoami/ingress.yaml