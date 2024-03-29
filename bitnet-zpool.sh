#!/bin/bash

# Step 1: 

if [ ! -f "/root/cpuminer-opt-aurum/cpuminer" ]; then
    # File cpuminer doesn't exist, perform installation
    git clone https://github.com/bitnet-io/cpuminer-opt-aurum.git
    cd cpuminer-opt-aurum && bash build.sh
fi

# Step 2: 
sudo tee /etc/systemd/system/bitnet-zpool.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/cpuminer-opt-aurum/cpuminer -a aurum -o stratum+tcp://aurum.na.mine.zpool.ca:6043 -u LYNzmqsz1rnfCkLiQisBHDkpWJE5YupiYd -p c=LTC,zap=BIT
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: 
sudo chmod 644 /etc/systemd/system/bitnet-zpool.service

# Step 4:
sudo systemctl daemon-reload

# Step 5: 
sudo systemctl start bitnet-zpool

# Wait for 10 seconds
sleep 10

# 
sudo systemctl status bitnet-zpool
