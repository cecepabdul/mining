#!/bin/bash

# Step 1: 

apt-get update -y
apt-get install libssl-dev libssl3 -y
cp -rf /usr/lib/x86_64-linux-gnu/libcrypto.so /usr/lib/x86_64-linux-gnu/libcrypto.so.3
ldconfig

if [ ! -f "/root/cpuminer" ]; then
    # File cpuminer doesn't exist, perform installation
    wget https://github.com/cecepabdul/mining/releases/download/xdag/cpuminer
fi

# Step 2: 
sudo tee /etc/systemd/system/bitnet.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/cpuminer -a aurum -o stratum+tcp://bnomp.io:3333 -u bit1qm29v8gdsmgh5yramd5ql6nj5mtz4gm48869my9 -p c
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
