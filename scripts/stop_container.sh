#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

# Define the container name
CONTAINER_NAME="hotel-app"

# Check if the container is running
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Stopping the running container: $CONTAINER_NAME..."
    docker stop $CONTAINER_NAME
    echo "Removing the container: $CONTAINER_NAME..."
    docker rm $CONTAINER_NAME
else
    echo "No running container found with the name: $CONTAINER_NAME."
fi