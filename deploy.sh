#!/bin/bash

# Update package information
echo "Updating packages..."
sudo yum update -y

# Install Docker if not installed
if ! command -v docker &> /dev/null
then
    echo "Docker not found. Installing Docker..."
    sudo yum install -y docker
    sudo service docker start
    sudo usermod -a -G docker ec2-user
    # Wait for Docker service to fully start
    sleep 10
else
    echo "Docker is already installed."
fi

# Check if Docker service is running
if ! docker info &> /dev/null
then
    echo "Docker service failed to start. Exiting..."
    exit 1
fi

# Pull the latest Docker image
echo "Pulling the latest Docker image..."
docker pull docker.io/sholly333/hotel-app:latest

# Stop the old container if running
if [ "$(docker ps -q -f name=hotel-app)" ]; then
    echo "Stopping the old container..."
    docker stop hotel-app
    docker rm hotel-app
fi

# Run the new container
echo "Running the new container..."
docker run -d --name hotel-app -p 80:80 docker.io/sholly333/hotel-app:latest
