#!/bin/bash

sudo su -
sudo apt update

if ! command -v docker &> /dev/null
then
    echo "Docker belum terinstal. Melakukan instalasi..."
    curl -fsSL https://get.docker.com | sh
else
    echo "Docker sudah terinstal."
fi
