# Purpose
Experiment with different aspects of resiliency and chaos engineering

# How to run
## if using the MQ Explorer grant access to X11 on the host to the docker network
xhost + 127.0.0.1
docker-compose up

# MQ
## MQ Native HA and clustering across aws regions
Setup clustering
Run via docker compose
Access UI via https://localhost:9443/ibmmq/console admin | passw0rd
https://developer.ibm.com/tutorials/mq-setting-up-using-ibm-mq-console/
https://github.com/ibm-messaging/mq-container/blob/master/docs/developer-config.md

Success: ability to run in native HA via docker compose
# Event Sourcing
## Purpose
Create an event sourcing version of a microservice that is consuming messages from
The MQ and publishes to Kafka and then reads back from there to update its own internal data store.
https://eventstore.js.org/
https://medium.com/@qasimsoomro/building-microservices-using-node-js-with-ddd-cqrs-and-event-sourcing-part-1-of-2-52e0dc3d81df

# Chaos Engineering
## Purpose
Emulate all the typical failures to understand the impact of them and build out detection and healing

Tools to inject specific failures / degradations into the docker environment, like network partitions etc.
https://codefresh.io/docker-tutorial/chaos_testing_docker/

## Needs
Some form of steady state via testing that can be observed and changed via chaos tools.

# Components needed
Kafka, Zookeeper
MQ server
Microservice and data base consumer
MQ Producer for testing

## MQ Client library needs to be installed and on the dynamic load path
export DYLD_LIBRARY_PATH=/opt/mqm/lib64


# Evolution to test resiliency
## Clusters
MQ, Kafka, Zookeeper, microservice, database

## Failure injection
Find a decent chaos engineering solution and use it to insert the required failures
https://codefresh.io/docker-tutorial/chaos_testing_docker/
https://github.com/alexei-led/pumba
https://livebook.manning.com/book/chaos-engineering/copyright-2020-manning-publications/v-5/

# To get a shell as root user in the kubernetes cluster's containers
https://github.com/jordanwilson230/kubectl-plugins
run (pod name, first container in the pod, or specify container name
```
kubectl ssh -u root secureapphelm-ibm-mq-0
```


# DOING
MQ cluster with native HA - three nodes.


# TODO
Kafka Broker
Consumer publish to Kafka
Consumer consume from Kafka and update local data store / read model

# DONE
MQ producer that can connect and deliver a message to the server
MQ Container
MQ UI
MQ Consumer service - just connect, get message and print
MQ create queue via config file, so that there is a way to use config files for all the rest
