# Purpose
Experiment with different aspects of resiliency and chaos engineering

# How to run
docker-compose up

# MQ
## MQ Native HA and clustering across aws regions
Setup clustering
Run via docker compose
Access UI via https://localhost:9443/ibmmq/console admin | passw0rd
https://developer.ibm.com/tutorials/mq-setting-up-using-ibm-mq-console/
https://github.com/ibm-messaging/mq-container/blob/master/docs/developer-config.md

# Event Sourcing
## Purpose
Create an event sourcing version of a microservice that is consuming messages from
The MQ and publishes to Kafka and then reads back from there to update its own internal data store.


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


# DOING
MQ Consumer service

# TODO
MQ create queue via config file
Kafka Broker
Consumer publish to Kafka
Consumer consume from Kafka and update local data store / read model

# DONE
MQ producer that can connect and deliver a message to the server
MQ Container
MQ UI
