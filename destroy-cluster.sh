#!/bin/bash
# This decommissions all the resources, and allows a fresh start
export TARGET_NAMESPACE=default

helm delete secureapphelm
kubectl delete secret helmsecure -n $TARGET_NAMESPACE
kubectl delete configmap helmsecure -n $TARGET_NAMESPACE
kubectl delete pvc data-secureapphelm-ibm-mq-0 -n $TARGET_NAMESPACE
kubectl delete pvc data-secureapphelm-ibm-mq-1 -n $TARGET_NAMESPACE
kubectl delete pvc data-secureapphelm-ibm-mq-2 -n $TARGET_NAMESPACE

minikube stop -p nativeha
minikube delete -p nativeha
