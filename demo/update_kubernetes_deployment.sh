#!/bin/bash

# Deployment name
DEPLOYMENT_NAME="demo-app"

# Service name
SERVICE_NAME="mykafka-service"

# Docker image name
DOCKER_IMAGE="runmydocker/demo-app"

# Build and push the Docker image with the "latest" tag
docker build -t $DOCKER_IMAGE:latest .
docker push $DOCKER_IMAGE:latest

# Check for the new image
docker images

# Make sure you are in the correct namespace context
kubectl config set-context --current --namespace=my-kafka

# Apply the deployment to Kubernetes
kubectl apply -f deployment.yaml

# Apply the image in the Kubernetes deployment environment
kubectl set image deployment/$DEPLOYMENT_NAME demo-app=$DOCKER_IMAGE:latest

# Force rollout even if the configuration hasn't changed
kubectl rollout restart deployment $DEPLOYMENT_NAME

# Final check 1
kubectl get pods

# Final check 2
kubectl get deployments

# Final check 3: View the update status
kubectl rollout status deployment/$DEPLOYMENT_NAME # deployment "demo-app" successfully rolled out

# Delete and recreate the service to force an update
kubectl delete service $SERVICE_NAME
kubectl apply -f service.yaml

# Final check 4
kubectl get services
