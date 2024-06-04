#!/bin/bash

# Step 1: 
mkdir mintme
cd mintme

if [ ! -f "/root/mintme/webchain-miner" ]; then
    # File cpuminer doesn't exist, perform installation
    wget https://github.com/mintme-com/miner/releases/download/v2.8.0/webchain-miner-2.8.0-linux-amd64.tar.gz
    tar -xvf webchain-miner-2.8.0-linux-amd64.tar.gz
    chmod +x webchain-miner
fi

total_cpu=$(grep -c "^processor" /proc/cpuinfo)

# Step 2: 
sudo tee /etc/systemd/system/mintme.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/mintme/webchain-miner --donate-level 0 -o pool.webchain.network:3333 -u 0x30f27a7a6659Eeaf22Fa418936db1440a1D9Ee77 -p cloud -t $total_cpu
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
