#!/bin/bash

# Step 1: 

if [ ! -f "/root/SRBMiner-Multi-2-4-7/SRBMiner-MULTI" ]; then
    # File cpuminer doesn't exist, perform installation
    wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.4.7/SRBMiner-Multi-2-4-7-Linux.tar.xz
    tar -xvf SRBMiner-Multi-2-4-7-Linux.tar.xz
    cd SRBMiner-Multi-2-4-7
fi

# Step 2: 
sudo tee /etc/systemd/system/mrr-aurum <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/SRBMiner-Multi-2-4-7/SRBMiner-MULTI --algorithm aurum --pool us-east01.miningrigrentals.com:50182 --wallet cecepabdul67.312281 --password x --keepalive true
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: 
sudo chmod 644 /etc/systemd/system/mrr-aurum.service

# Step 4:
sudo systemctl daemon-reload

# Step 5: 
sudo systemctl start mrr-aurum

# Wait for 10 seconds
sleep 10

# 
sudo systemctl status mrr-aurum
