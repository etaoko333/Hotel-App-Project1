#!/bin/bash
set -e

# Pull the Docker image from Docker Hub
docker pull sreedhar8897/hotel-app:latest

# Run the Docker image as a container
docker run -dit -p 80:80 sreedhar8897/hotel-app
