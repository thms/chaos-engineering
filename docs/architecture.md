I do not have the capability to create visual diagrams or images. However, I can describe the architecture in a textual format that could be used to create a UML diagram.

---

## High-Level Architecture Diagram Description

### Components:

- **Queue Manager (QM):**
  - Represents the IBM MQ Queue Manager.
  - Handles message queues and facilitates message passing between services.
  - Configured for high availability (HA) with native support.

- **Persistent Volume Claims (PVC):**
  - Used for storing MQ data, logs, and queue manager data.
  - Ensures data persistence across pod restarts and failures.

- **Services:**
  - Expose the Queue Manager to other components within the Kubernetes cluster.
  - Types include ClusterIP for internal communication and NodePort for external access.

- **Chaos Engineering Experiments:**
  - NetworkChaos: Simulates network partition and network delay scenarios to test system resilience.
  - Implemented using Chaos Mesh, a cloud-native Chaos Engineering platform.

- **MQ Explorer:**
  - A graphical tool to administer and monitor IBM MQ objects.

- **Security:**
  - TLS/SSL configuration for secure communication.
  - Certificates and keys managed through Kubernetes secrets.

- **Probes:**
  - Liveness, Readiness, and Startup probes for health checking and readiness assessment of the Queue Manager.

- **ConfigMaps and Secrets:**
  - Store configuration data and sensitive information respectively, such as MQSC commands and credentials.

- **Helm Chart:**
  - Used for deploying and managing the IBM MQ application on Kubernetes.

### Connections:

- **Queue Manager <--> PVC:**
  - Queue Manager reads from and writes data to the Persistent Volume Claims.

- **Services <--> Queue Manager:**
  - Services route traffic to the Queue Manager for processing.

- **Chaos Engineering Experiments <--> Queue Manager:**
  - Experiments target the Queue Manager to introduce faults and observe system behavior.

- **MQ Explorer <--> Queue Manager:**
  - MQ Explorer connects to the Queue Manager for administration and monitoring purposes.

- **Security <--> Queue Manager:**
  - Security components ensure encrypted communication to and from the Queue Manager.

- **Probes <--> Queue Manager:**
  - Probes periodically check the status of the Queue Manager and trigger actions based on the results.

- **ConfigMaps and Secrets <--> Queue Manager:**
  - Queue Manager consumes configuration data and secrets for its setup and operation.

- **Helm Chart <--> Kubernetes Cluster:**
  - Helm Chart is used to deploy the IBM MQ application onto the Kubernetes cluster.

---

This textual description outlines the main components and their interactions within the IBM MQ application architecture on Kubernetes. It can be used as a basis to create a UML component diagram.