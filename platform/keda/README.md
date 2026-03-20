# KEDA

KEDA (Kubernetes Event-Driven Autoscaling) enables event-based scaling of workloads.

## Installation

./platform/keda/install.sh

## Usage

A ScaledObject is used to scale the worker deployment based on RabbitMQ queue length.

## Notes

Requires network access to RabbitMQ (port 5672)
