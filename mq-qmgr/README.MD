# IBM MQ QueueManager cluster in Native HA



# Own docker image
## Problem to Solve
The orginal QM image does not have ping and other test items so it is quite hard
to figure out if the ChaosMesh stuff is working.

## Solution
Build new docker image with the additional utilities installed.
That way ping and so on are available to test that ChaosMesh works as expected.
I.e. inserting a delay between the leader and follower of a node or between regions in general.

## Build & Push to local registry in Kubernetes
This assumes Docker Desktop is used to build the images.
TODO: switch to BuildKit or Podman?
make sure local registry in Minikube is running
```
minikube addons enable registry
```
Run proxy to allow docker push to reach the registry inside the Minikube cluster
The registry must be up and running first, as socat attempts to connect to it.
https://linux.die.net/man/1/socat
```
docker run --rm -it --network=host alpine ash -c "apk add socat && socat TCP-LISTEN:5000,reuseaddr,fork TCP:$(minikube ip):5000"
```
Finally build container and push to registry.
```
docker build -t localhost:5000/mq-qmgr -f ./Dockerfile .
docker push localhost:5000/mq-qmgr
```
Inside of helm charts, refer to the image as
name: localhost:5000/mq-qmgr
tag: latest
