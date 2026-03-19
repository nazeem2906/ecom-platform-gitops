
## `docs/architecture/overview.md`

```md
# Architecture Overview

This repository describes a production-like Kubernetes platform running on kind.

Main building blocks:
- local kind cluster
- ingress-nginx
- argocd
- application namespaces: dev, staging, prod
- data namespace
- monitoring and logging
- security controls
- backup and restore