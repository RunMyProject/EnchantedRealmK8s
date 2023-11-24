#!/bin/bash

# Nome del deployment
DEPLOYMENT_NAME="demo-app"

# Nome del servizio
SERVICE_NAME="mykafka-service"

# Nome dell'immagine Docker
DOCKER_IMAGE="runmydocker/demo-app"

# Costruzione e push dell'immagine Docker con etichetta "latest"
docker build -t $DOCKER_IMAGE:latest .
docker push $DOCKER_IMAGE:latest

# Verifica immagine nuova
docker images

# assicurati di essere nel contesto del namespace corretto
kubectl config set-context --current --namespace=my-kafka

# Applica il deployment su Kubernetes
kubectl apply -f deployment.yaml

# Applicazione dell'immagine nell'ambiente di deployment di Kubernetes
kubectl set image deployment/$DEPLOYMENT_NAME demo-app=$DOCKER_IMAGE:latest

# Forza il rollout anche se la configurazione non è cambiata
kubectl rollout restart deployment $DEPLOYMENT_NAME

# Verifica finale 1
kubectl get pods

# Verifica finale 2
kubectl get deployments

# Verifica finale 3: Visualizzazione dello stato dell'aggiornamento
kubectl rollout status deployment/$DEPLOYMENT_NAME # deployment "demo-app" successfully rolled out

# Elimina e ricrea il servizio per forzarne l'aggiornamento
kubectl delete service $SERVICE_NAME
kubectl apply -f service.yaml

# Verifica finale 4
kubectl get services
