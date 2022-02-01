#!/bin/bash
# To start or stop the cluster just use minikube start|stop -p nativeha
# Set up minikube cluster and load the basics
# Setup env variables too
export CLUSTERNAME=nativeha
minikube start -n 3 -p $CLUSTERNAME --driver=hyperkit --insecure-registry="10.0.0.0/24"
minikube profile $CLUSTERNAME

# Install the kubernetes dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.4.0/aio/deploy/recommended.yaml
kubectl apply -f kubernetes-dashboard.yaml

# To access the dashboard
# kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"
# kubectl proxy
# http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login

# Run local registry inside of the Kubernetes cluster
minikube addons enable registry

# Install ChaosMesh
kubectl create namespace chaos-mesh
helm repo add chaos-mesh https://charts.chaos-mesh.org
helm install chaos-mesh chaos-mesh/chaos-mesh --namespace=chaos-mesh --set dashboard.create=true --set dashboard.securityMode=false

# kubectl apply -f ./chaos-dashboard.yaml
# helm upgrade chaos-mesh chaos-mesh/chaos-mesh --namespace=chaos-mesh  --set dashboard.securityMode=false

# Install weave scope
# https://www.weave.works/docs/scope/latest/installing/#k8s
kubectl apply -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '\n')"
# open weave ui on http://localhost:4040/
# kubectl port-forward -n weave "$(kubectl get -n weave pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040
