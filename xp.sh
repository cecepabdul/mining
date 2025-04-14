#!/bin/bash


# Step 1: 
if [ ! -f "/root/miner-linux-amd64" ]; then
        wget https://github.com/xpherechain/Xphere-miner/releases/download/v0.0.5/miner-linux-amd64 && chmod +x miner-linux-amd64
fi

# Step 2: 
sudo tee /etc/systemd/system/xp.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/miner-linux-amd64 -stratum stratum+tcp://0xaAd5A8a2D314c939B7027a95CD6768a8eDe37A43.cloud:x@stratum-sgp.x-phere.com:33333
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: 
sudo chmod 644 /etc/systemd/system/xp.service

# Step 4:
sudo systemctl daemon-reload

# Step 5: 
sudo systemctl start xp.service

# Wait for 10 seconds
sleep 10

# 
journalctl -f -u xp.service
