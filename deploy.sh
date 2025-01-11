#!/bin/bash

# Update package information
echo "Updating packages..."
sudo yum update -y

# Install Docker if not installed
if ! command -v docker &> /dev/null; then
    echo "Docker not found. Installing Docker..."
    sudo yum install -y docker
    sudo service docker start
    # Ensure the codedeploy-agent user has permission to run Docker
    sudo usermod -aG docker codedeploy-agent
    sleep 5  # Wait for Docker service to start
else
    echo "Docker is already installed."
fi

# Export Docker path
export PATH=$PATH:/usr/bin

# Check if Docker service is running
if ! /usr/bin/docker info &> /dev/null; then
    echo "Docker service failed to start. Exiting..."
    exit 1
fi

# Pull the latest Docker image
echo "Pulling the latest Docker image..."
/usr/bin/docker pull docker.io/sholly333/hotel-app:latest

# Stop the old container if running
if [ "$(docker ps -q -f name=hotel-app)" ]; then
    echo "Stopping the old container..."
    /usr/bin/docker stop hotel-app
    /usr/bin/docker rm hotel-app
fi

# Run the new container
echo "Running the new container..."
/usr/bin/docker run -d --name hotel-app -p 80:80 docker.io/sholly333/hotel-app:latest
