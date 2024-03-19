#!/bin/bash

# Step 1: 
if [ ! -f "/root/qubic/qli-Client" ]; then
    # File cpuminer-avx doesn't exist, perform installation
    wget https://github.com/cecepabdul/mining/releases/download/xdag/qubic.tar
    tar -xvf /root/qubic.tar 
    rm -rf qubic.tar
    fi

# Step 2: 
sudo tee /etc/systemd/system/qubic.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/qubic/qli-Client
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: 
sudo chmod 644 /etc/systemd/system/qubic.service

# Step 4:
sudo systemctl daemon-reload

# Step 5: 
sudo systemctl start qubic

# Wait for 10 seconds
sleep 10

# 
journalctl -f -u qubic
