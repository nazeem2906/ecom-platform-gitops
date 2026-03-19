# ecom-platform-gitops

Production-like Kubernetes platform running locally on kind.

## Goals

Build a portfolio-grade Kubernetes platform with:

- kind
- Ingress NGINX
- Argo CD
- Helm + Kustomize
- Prometheus / Grafana / Loki
- RBAC / NetworkPolicies / Pod Security
- PostgreSQL / Redis / RabbitMQ
- Velero

## Project structure

- `bootstrap/`: cluster and namespaces bootstrap
- `platform/`: platform components (ingress, metrics, argocd, ...)
- `tests/`: validation workloads
- `docs/`: architecture, runbooks, ADRs
- `screenshots/`: portfolio screenshots

## Current status

- [x] Repository structure
- [x] kind bootstrap files
- [x] namespaces
- [x] ingress-nginx install files
- [x] metrics-server install files
- [x] whoami ingress test
- [ ] Argo CD
- [ ] Applications
- [ ] Observability
- [ ] Security
- [ ] Backup / Restore

## Local access

- HTTP ingress: `http://localhost:8080`
- HTTPS ingress: `https://localhost:8443`
- Local registry: `localhost:5001`

## Architecture

See `docs/architecture/overview.md`