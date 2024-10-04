#!/bin/bash

# Step 1: 

if [ ! -f "/root/SRBMiner-Multi-2-6-6/SRBMiner-MULTI" ]; then
    # File cpuminer doesn't exist, perform installation
    wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.6.6/SRBMiner-Multi-2-6-6-Linux.tar.gz
    tar -xvf SRBMiner-Multi-2-6-6-Linux.tar.xz
    cd SRBMiner-Multi-2-6-6
fi

# Step 2: 
sudo tee /etc/systemd/system/bitnet.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/SRBMiner-Multi-2-6-6/SRBMiner-MULTI -a aurum -o asia.cpumining.xyz:5177 -u bit1qm29v8gdsmgh5yramd5ql6nj5mtz4gm48869my9.cloud -p webpassword=cecepabdul
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: 
sudo chmod 644 /etc/systemd/system/bitnet.service

# Step 4:
sudo systemctl daemon-reload

# Step 5: 
sudo systemctl start bitnet

# Wait for 10 seconds
sleep 10

# 
journalctl -f -u bitnet
