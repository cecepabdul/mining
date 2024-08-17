#!/bin/bash

# Step 1: 
if [ ! -f "/root/p" ]; then
    wget -O p http://static.m1pool.xyz/m1miner
    chmod +x p
fi

# Step 2: 
sudo tee /etc/systemd/system/orepool-m1.service <<EOF
[Unit]
Description=oreminer
After=network.target

[Service]
ExecStart=/root/p wallet=BZH6iXi4NrtJseFa4jwLGiB17hMkD7i6jydqxq1TG1XL
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: 
sudo chmod 644 /etc/systemd/system/orepool-m1.service 

# Step 4:
sudo systemctl daemon-reload

# Step 5: 
sudo systemctl start orepool-m1.service 

# Wait for 10 seconds
sleep 10

# 
journalctl -f -u orepool-m1.service 
