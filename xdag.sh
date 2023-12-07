#!/bin/bash

# Step 1: 
if [ ! -d "/root/xdag/xmrig-4-xdag" ]; then
    # Folder xmrigcc doesn't exist, perform installation
    mkdir /root/xdag
    cd /root/xdag
    wget https://github.com/cecepabdul/mining/releases/download/xdag/config.json
    wget https://github.com/cecepabdul/mining/releases/download/xdag/xmrig-4-xdag
    chmod +x xmrig-4-xdag
fi

# Step 2: 
sudo tee /etc/systemd/system/xdag.service <<EOF
[Unit]
Description=xdag Service
After=network.target

[Service]
ExecStart=/root/xdag/xmrig-4-xdag
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: 
sudo chmod 644 /etc/systemd/system/xdag.service

# Step 4:
sudo systemctl daemon-reload

# Step 5: 
sudo systemctl start xdag

# Wait for 10 seconds
sleep 10

# 
sudo systemctl status xdag
