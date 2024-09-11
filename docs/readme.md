# README for Chaos Engineering Microservices

## API

The codebase does not explicitly define an API in the traditional sense of a RESTful or GraphQL API. However, it does include various shell scripts, YAML configurations, and JavaScript files that interact with Kubernetes and IBM MQ resources, which can be considered part of the operational API for the chaos engineering experiments.

## Data Model

The data model revolves around Kubernetes resources and IBM MQ configurations. The primary entities include:

- **Kubernetes Objects**: Such as `Service`, `StatefulSet`, `ServiceAccount`, `ClusterRole`, `ClusterRoleBinding`, and `PersistentVolumeClaim`.
- **IBM MQ Resources**: Queue Managers, Queues, Channels, and associated configuration like `mqsc` and `ini` files for setting up the MQ environment.
- **Chaos Mesh Experiments**: Defined in YAML to introduce network partitions and delays for testing the resilience of the system.

## Business Logic

The business logic is encapsulated in the form of shell scripts and Kubernetes YAML configurations that set up and manage the state of IBM MQ queue managers and perform chaos engineering experiments using Chaos Mesh. The logic includes:

- Setting up a Kubernetes cluster with the necessary resources.
- Installing and configuring IBM MQ queue managers with TLS and native HA support.
- Executing chaos experiments to test network partitions and delays.
- Cleaning up resources and decommissioning the environment.

## Events Consumed

The system does not consume events in the traditional sense but is affected by Kubernetes and IBM MQ events such as:

- Kubernetes lifecycle events (e.g., pod creation, termination).
- IBM MQ events related to queue manager state changes.

## Events Published

The system does not explicitly publish events. However, it does produce outputs and logs that can be monitored, such as:

- Logs from the execution of shell scripts.
- IBM MQ logs and metrics exposed for Prometheus scraping.
- Kubernetes events related to the state of the resources managed by the scripts and configurations.

---

**Note**: The codebase provided does not include a running service that exposes an API endpoint or publishes/consumes events in a message-driven architecture. The README is based on the interpretation of the scripts and configurations as they relate to Kubernetes and IBM MQ operations within the context of chaos engineering experiments.