# Create a namespace to run the experiements in
kubectl create namespace chaos-mesh

# Add the helm repos
helm repo add chaos-mesh https://charts.chaos-mesh.org

# Install the chart
helm install chaos-mesh chaos-mesh/chaos-mesh \
  --namespace chaos-mesh

# Get the url for the dashboard
minikube service list -n chaos-mesh
