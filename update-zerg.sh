#!/bin/bash

# Step 1: 
sudo systemctl stop bitnet
rm -rf /etc/systemd/system/bitnet.service

# Step 2: 
sudo tee /etc/systemd/system/bitnet.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/cpuminer -a aurum -o stratum+tcp://aurum.na.mine.zergpool.com:6434 -u TZGQwQ58mdfVg5Tr7ap91pDq4GGARtGYrj -p c=TRX,mc=BIT,m=solo
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
