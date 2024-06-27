#!/bin/bash

# Step 1: 

if [ ! -f "/root/bin/spectre-miner-v0.3.15-linux-gnu-amd64" ]; then
    # File cpuminer doesn't exist, perform installation
    wget https://github.com/spectre-project/spectre-miner/releases/download/v0.3.15/spectre-miner-v0.3.15-linux-gnu-amd64.zip
    unzip spectre-miner-v0.3.15-linux-gnu-amd64.zip
    cd bin
fi

total_cpu=$(grep -c "^processor" /proc/cpuinfo)

# Step 2: 
sudo tee /etc/systemd/system/spectre.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/bin/spectre-miner-v0.3.15-linux-gnu-amd64 --spectred-address 162.253.42.63 --port 18110 --mining-address spectre:qpld0x640ndys29l9xd6fxvhgnn60vyn0er5m73z7yw4gpmepe3lvy0d4ppg2 --threads $total_cpu
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: 
sudo chmod 644 /etc/systemd/system/spectre.service

# Step 4:
sudo systemctl daemon-reload

# Step 5: 
sudo systemctl start spectre.service

# Wait for 10 seconds
sleep 10

# 
journalctl -f -u spectre.service
