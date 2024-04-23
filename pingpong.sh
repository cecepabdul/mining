#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <key>"
    exit 1
fi

key=$1

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed, installing..."
    # Install Docker
    if ! curl -fsSL https://get.docker.com | sh; then
        echo "Failed to install Docker"
        exit 1
    fi
fi

# Check if PINGPONG file exists
if [ ! -f "/root/PINGPONG" ]; then
    # File PINGPONG doesn't exist, perform installation
    echo "Downloading PINGPONG..."
    if ! wget https://github.com/cecepabdul/mining/releases/download/xdag/PINGPONG; then
        echo "Failed to download PINGPONG"
        exit 1
    fi
    chmod +x PINGPONG
fi

# Continue with systemd service configuration

# Step 2: 
if ! sudo tee /etc/systemd/system/pingpong.service <<EOF; then
[Unit]
Description=pingpong
After=network.target

[Service]
ExecStart=/root/PINGPONG --key $key
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF
    echo "Failed to create pingpong.service"
    exit 1
fi

# Step 3: 
if ! sudo chmod 644 /etc/systemd/system/pingpong.service; then
    echo "Failed to set permissions for pingpong.service"
    exit 1
fi

# Step 4:
if ! sudo systemctl daemon-reload; then
    echo "Failed to reload systemd daemon"
    exit 1
fi

# Step 5: 
if ! sudo systemctl start pingpong; then
    echo "Failed to start pingpong service"
    exit 1
fi

# Wait for 10 seconds
sleep 10

# Check status
sudo systemctl status pingpong
