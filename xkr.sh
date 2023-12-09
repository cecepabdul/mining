#!/bin/bash

# Step 1: 
if [ ! -d "/root/xmrigcc" ]; then
    # Folder xmrigcc doesn't exist, perform installation
    wget https://github.com/Bendr0id/xmrigCC/releases/download/3.4.0/xmrigCC-miner_only-3.4.0-linux-dynamic-amd64.tar.gz -O /root/xmrigcc.tar.gz
    mkdir /root/xmrigcc
    tar -xvf /root/xmrigcc.tar.gz -C /root/xmrigcc
fi

# Step 2: 
sudo tee /etc/systemd/system/xkr.service <<EOF
[Unit]
Description=xmrigcc-xkr Service
After=network.target

[Service]
ExecStart=/root/xmrigcc/xmrigDaemon -a cn-pico -o privacymine.net:5555 -u SEKReV1jVbX6iQX1CJ2GHgKzktJug8j9K9omRYHiJMpmJyhtrdPbGaA8V5i9mSRQZTKpV8RH9moPeV2uqa5VX5JPRP5y8kncrcg+b -p c -k --cc-url=172.111.10.111:3344 --cc-access-token=Cecepabdul67 --donate-level=1
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: 
sudo chmod 644 /etc/systemd/system/xmrigcc-xdag.service

# Step 4:
sudo systemctl daemon-reload

# Step 5: 
sudo systemctl start xkr

# Wait for 10 seconds
sleep 10

# 
sudo systemctl status xkr
