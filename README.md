# Purpose
Experiment with different aspects of resiliency and chaos engineering 

# How to run
docker-compose up

# MQ
## MQ Native HA and clustering across regions
Setup clustering

# Event Sourcing
## Purpose
Create an event sourcing version of a microservice that is consuming messages from
The MQ and publishes to Kafka and then reads back from there to update its own internal data store.


# Components needed
Kafka, Zookeeper
MQ server
Microservice and data base



# Evolution to test resiliency
## Clusters
MQ, Kafka, Zookeeper, microservice, database

## Failure injection
Find a decent chaos engineering solution and use it to insert the required failures
https://codefresh.io/docker-tutorial/chaos_testing_docker/
https://github.com/alexei-led/pumba
https://livebook.manning.com/book/chaos-engineering/copyright-2020-manning-publications/v-5/
