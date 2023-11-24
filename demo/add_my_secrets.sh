#!/bin/bash

# Check if sufficient arguments are provided
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <namespace> <docker-username> <docker-password>"
  exit 1
fi

NAMESPACE="$1"
DOCKER_USERNAME="$2"
DOCKER_PASSWORD="$3"

# Create Docker Registry secret with provided credentials in the specified namespace
kubectl create secret docker-registry my-docker-secret --docker-username="$DOCKER_USERNAME" --docker-password="$DOCKER_PASSWORD" -n "$NAMESPACE"

# Get and display the secret
SECRET_DATA=$(kubectl get secret my-docker-secret -o jsonpath="{.data}" -n "$NAMESPACE")
echo "Secret Data:"
echo "$SECRET_DATA"

# Get and display all secrets in the specified namespace
kubectl get secret -n "$NAMESPACE"

