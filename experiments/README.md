# Chaos experiments

## Network delay
Introduces a delay between the primary pod and the replicas for the MQ server

kubectl apply -f network-delay.yaml


## Network partition
Create a partition between the primary and one of the replicas
