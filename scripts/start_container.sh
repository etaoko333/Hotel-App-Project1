#!/bin/bash
set -e

# Pull the Docker image from Docker Hub
docker pull sholly333/hotel-app:latest

# Run the Docker image as a container
docker run -dit -p 8084:80 sholly333/hotel-app
