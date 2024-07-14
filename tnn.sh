#!/bin/bash

# Step 1: 

mkdir tnn
cd tnn

if [ ! -f "/root/tnn/tnn-miner/tnn-miner" ]; then
    # File cpuminer doesn't exist, perform installation
    wget https://github.com/ddobreff/mmpos/releases/download/0.3.8-r1.6/tnn-miner-v0.3.8-r1.6.tar.gz
    tar -xvf tnn-miner-v0.3.8-r1.6.tar.gz
    cd tnn-miner
fi

total_cpu=$(grep -c "^processor" /proc/cpuinfo)

# Step 2: 
sudo tee /etc/systemd/system/tnn.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/tnn/tnn-miner/tnn-miner --spectre --daemon-address 162.253.42.88 --port 5555 --wallet spectre:qqw2xkm5f6wqwv2v642fgn206v7q59ef49sl94dmm4vvxtaxjsm8qdjv2pam8 --dev-fee 1 --threads $total_cpu --no-lock --worker-name bare
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
