#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

# Define the container name
CONTAINER_NAME="hotel-app"

# Pull the latest Docker image from Docker Hub
echo "Pulling the latest Docker image..."
docker pull sreedhar8897/hotel-app:latest

# Check if the container is already running and stop it if it is
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Stopping the existing container..."
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
fi

# Run the Docker image as a new container
echo "Starting the new container..."
docker run -dit --name $CONTAINER_NAME -p 80:80 sreedhar8897/hotel-app:latest

echo "Container started successfully."