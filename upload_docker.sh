#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
DOCKER_PATH="fernanalegria/boston-housing"

# Step 2:  
# Authenticate & tag
cat ~/docker_access_token.txt | docker login --username fernanalegria --password-stdin docker.io
docker tag boston-housing:latest $DOCKER_PATH:latest
echo "Docker ID and Image: $DOCKER_PATH"

# Step 3:
# Push image to a docker repository
docker push $DOCKER_PATH:latest

# Step 4:
# Log out of Docker Hub
docker logout