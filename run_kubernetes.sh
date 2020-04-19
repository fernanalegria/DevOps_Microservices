#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
DOCKER_PATH="fernanalegria/boston-housing"

# Step 2:
# Clean up previous deployments
if [ $(kubectl get pod boston-housing-pod -o jsonpath='{.kind}') ]
  then
    kubectl delete pod boston-housing-pod
fi

# Step 3:
# Run the Docker Hub container with kubernetes
kubectl run boston-housing-pod \
    --image=$DOCKER_PATH \
    --port=8000 \
    --labels app=boston-housing

# Step 4:
# List kubernetes pods
kubectl get pods

# Step 5:
# Forward the container port to a host
while [ $(kubectl get pod boston-housing-pod -o jsonpath="{.status.phase}") != "Running" ]; do
    echo "Deploying Boston housing pod..."
done
kubectl get pod boston-housing-pod
kubectl port-forward boston-housing-pod 8000:8000
