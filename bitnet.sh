#!/bin/bash

# Step 1: 

if [ ! -f "/root/cpuminer-opt-aurum/cpuminer" ]; then
    # File cpuminer doesn't exist, perform installation
    sudo apt update -y && sudo apt-get install build-essential automake libssl-dev libcurl4-openssl-dev libjansson-dev libgmp-dev zlib1g-dev git -y
    git clone https://github.com/bitnet-io/cpuminer-opt-aurum.git
    cd cpuminer-opt-aurum && bash build.sh
fi

# Step 2: 
sudo tee /etc/systemd/system/bitnet.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/cpuminer-opt-aurum/cpuminer -a aurum -o stratum-na.rplant.xyz:7109 -u bit1qm29v8gdsmgh5yramd5ql6nj5mtz4gm48869my9.cloud -p webpassword=cecepabdul
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
