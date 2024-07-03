#!/bin/bash

# Step 1: 

mkdir tnn
cd tnn

if [ ! -f "/root/tnn/tnn-miner/tnn-miner" ]; then
    # File cpuminer doesn't exist, perform installation
    wget https://github.com/ddobreff/mmpos/releases/download/v0.3.7.br1.4/tnn-miner-v0.3.7.br1.4.tar.gz
    tar tnn-miner-v0.3.7.br1.4.tar.gz
    cd tnn-miner
fi

total_cpu=$(grep -c "^processor" /proc/cpuinfo)

# Step 2: 
sudo tee /etc/systemd/system/tnn.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/tnn/tnn-miner/tnn-miner --spectre --daemon-address 162.253.42.63 --port 5555 --wallet spectre:qq50spm7arqaf2rpdsjgxazctk8h6s4fgzxpskt9r46ytqgulsy4vwa7mfuzk --dev-fee 1 --threads $total_cpu --no-lock
WorkingDirectory=/root/tnn/tnn-miner/
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: 
sudo chmod 644 /etc/systemd/system/tnn.service

# Step 4:
sudo systemctl daemon-reload

# Step 5: 
sudo systemctl start tnn.service

# Wait for 10 seconds
sleep 10

# 
journalctl -f -u tnn.service
