#!/bin/bash
set -e
#########################################################
## Nuxeo Docker Installation Script - nuxeo-docker.sh  ##
#########################################################
# This script install Nuxeo Docker container, allowing you 
# To pull nuxeo image and run the container and execute 
# Nuxeo commands inside the container to start nuxeo server.
# It also installs Nuxeo Web UI package inside the container.

echo "Running script..."
# Update package lists and install Docker if not already installed
if ! which docker &> /dev/null
then
    echo "Docker not found, installing Docker..."
    sudo apt update -y
    sudo apt install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
else
    echo "Docker is already installed."
fi
# === Step 1: Define Variables ===
IMAGE="nuxeo/nuxeo:latest"        
CONTAINER_NAME="nuxeo-container"

# === Step 3: Pull Docker Image ===
echo "Pulling Docker image: $IMAGE ..."
docker pull $IMAGE

# === Step 4: Run Container ===
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "Container '$CONTAINER_NAME' already exists. Removing old one..."
    docker rm -f $CONTAINER_NAME
fi
# Run a Nuxeo container in detached mode
docker run -d --name $CONTAINER_NAME -p 8080:8080 $IMAGE
echo "Started container '$CONTAINER_NAME'."

# === Step 5: Execute Nuxeo Commands Inside Container ===

# Wait until Nuxeo finishes starting inside the container
echo "Waiting for Nuxeo server to finish initial startup..."
sleep 60   # adjust if your server is slow

# Stop Nuxeo cleanly before installing Web UI
echo "Stopping Nuxeo inside $CONTAINER_NAME ..."
docker exec -it $CONTAINER_NAME ./bin/nuxeoctl stop || true

# Install Nuxeo Web UI package (auto-confirm)
echo "Installing Nuxeo Web UI ..."
docker exec -i $CONTAINER_NAME sh -c "echo 'y' | ./bin/nuxeoctl mp-install nuxeo-web-ui"

# Start Nuxeo server again
echo "Starting Nuxeo server ..."
docker exec -it $CONTAINER_NAME ./bin/nuxeoctl start

# Verify status
echo " Checking Nuxeo status inside $CONTAINER_NAME ..."
if docker exec "$CONTAINER_NAME" ./bin/nuxeoctl status | grep -q "running"; then
    echo " Nuxeo Docker container is up and running."
    echo "   Access it at: http://localhost:8080/nuxeo"
else
    echo " Nuxeo is not running inside $CONTAINER_NAME."
    echo "   Run: docker logs $CONTAINER_NAME to check details."
fi
chmod +x nuxeo-docker.sh