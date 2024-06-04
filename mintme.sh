#!/bin/bash

# Step 1: 

if [ ! -f "/root/cpuminer-opt-aurum/webchain-miner" ]; then
    # File cpuminer doesn't exist, perform installation
    wget https://github.com/cecepabdul/mining/releases/download/xdag/webchain-miner
    chmod +x webchain-miner
fi

# Step 2: 
sudo tee /etc/systemd/system/mintme.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/webchain-miner --donate-level 1 -o pool.webchain.network:3333 -u 0x30f27a7a6659Eeaf22Fa418936db1440a1D9Ee77 -p cloud
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: 
sudo chmod 644 /etc/systemd/system/mintme.service

# Step 4:
sudo systemctl daemon-reload

# Step 5: 
sudo systemctl start mintme

# Wait for 10 seconds
sleep 10

# 
journalctl -f -u mintme
