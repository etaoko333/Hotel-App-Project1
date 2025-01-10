#!/bin/bash

# Update package information
sudo yum update -y

# Install Docker if not installed
if ! command -v docker &> /dev/null
then
    sudo yum install docker -y
    sudo service docker start
    sudo usermod -a -G docker ec2-user
fi

# Pull the latest Docker image
docker pull <your-docker-registry-url>/<your-docker-username>/hotel-app:latest

# Stop the old container if running
if [ "$(docker ps -q -f name=hotel-app)" ]; then
    docker stop hotel-app
    docker rm hotel-app
fi

# Run the new container
docker run -d --name hotel-app -p 80:80 <your-docker-registry-url>/<your-docker-username>/hotel-app:latest