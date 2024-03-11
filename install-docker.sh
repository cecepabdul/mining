#!/bin/bash

#
if ! command -v docker &> /dev/null; then
    echo "Docker belum terinstal, menginstal Docker..."
    # Install Docker
    apt update -y
    curl -fsSL https://get.docker.com | sh
    echo "Docker telah terinstal."
else
    echo "Docker sudah terinstal."
fi

# 
if docker ps -a --format '{{.Names}}' | grep -q 'tm'; then
    echo "Menghapus container Docker dengan nama 'tm'..."
    docker stop tm
    docker rm tm
fi

# 
docker pull traffmonetizer/cli_v2:latest
docker run -d --name tm traffmonetizer/cli_v2:latest start accept --token j/8mvzZq1NGzVUwAjjAZYmPYHlHyLchRNyK1BNKNL6E= --device-name cloud
