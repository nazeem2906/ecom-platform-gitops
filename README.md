# ecom-platform-gitops

Production-like Kubernetes platform running locally on kind, managed with GitOps (Argo CD).

## Overview

This project demonstrates how to build a complete Kubernetes platform locally using production patterns:

- GitOps with Argo CD (app-of-apps)
- Infrastructure as Code with Helm and Kustomize
- Progressive delivery with Argo Rollouts
- Event-driven autoscaling with KEDA
- Observability with Prometheus, Grafana, and Loki
- Security with RBAC, NetworkPolicies, and Kyverno
- Backup and restore with Velero and MinIO

## Architecture

Main components:

- Kubernetes: kind
- Ingress: ingress-nginx
- GitOps: Argo CD
- Monitoring: Prometheus + Grafana
- Logging: Loki + Promtail
- Messaging: RabbitMQ
- Autoscaling: KEDA
- Progressive delivery: Argo Rollouts
- Backup: Velero + MinIO
- Security: Kyverno + NetworkPolicies

<img width="2514" height="1084" alt="image" src="https://github.com/user-attachments/assets/74910759-c98e-40d3-900b-d4cf48d376f5" />
  

See `docs/architecture/overview.md` for details.

---

## Project Structure

```
.
├── apps/                # Application manifests (Kustomize)
├── bootstrap/           # Cluster bootstrap scripts
├── platform/            # Platform components (Helm installs)
├── gitops/              # Argo CD applications
├── policies/            # Security policies (Kyverno, NetworkPolicy)
├── docs/                # Architecture, ADRs, runbooks
├── screenshots/         # Demo screenshots
└── tests/               # Test workloads (whoami, etc.)
```

---

## Bootstrap the Platform

### 1. Create cluster

```bash
./bootstrap/kind/create-cluster.sh
```

### 2. Install platform

```bash
./bootstrap/bootstrap-platform.sh
```

### 3. Access Argo CD

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

---

## Local Access

| Service     | URL                             |
| ----------- | ------------------------------- |
| Argo CD     | https://localhost:8080          |
| Frontend    | https://ecommerce-dev.localhost |
| Grafana     | https://grafana.localhost       |
| RabbitMQ UI | http://localhost:15672          |

---

## Screenshots

All screenshots are available in `/screenshots`:

* Bootstrap & cluster
* Ingress routing
* Argo CD GitOps
* Applications & rollout
* RabbitMQ queues
* Observability dashboards
* Security policies
* Backup & restore
* GitOps workflow

---

## Features

### GitOps

* App-of-apps pattern
* Automatic sync from Git

### Progressive Delivery

* Canary deployments with Argo Rollouts

### Autoscaling

* Event-driven scaling using KEDA (RabbitMQ queue length)

### Observability

* Metrics: Prometheus
* Dashboards: Grafana
* Logs: Loki

### Security

* NetworkPolicies (zero trust)
* Kyverno policies (e.g. no `latest` tag)

### Backup

* Velero backups to MinIO
* Namespace restore capability

---

## Known Limitations

* KEDA RabbitMQ trigger partially validated (connectivity tuning required)
* Local TLS uses self-signed certificates
* Designed for local lab (not production-ready)

---

## Testing

Example:

```bash
kubectl get pods -n dev
kubectl argo rollouts get rollout frontend -n dev
kubectl get scaledobject -n dev
```

---

## Author

Built as a **Nassim A**.

---

## Next Improvements

* External DNS
* Real cloud deployment (EKS / GKE)
* CI pipeline (GitHub Actions)
* Secret management (Vault / External Secrets)

---
