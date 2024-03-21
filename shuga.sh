#!/bin/bash

# Step 1: 
if [ ! -f "/root/cpu/cpuminer-sse2" ]; then
    mkdir cpu && cd cpu
    wget https://github.com/rplant8/cpuminer-opt-rplant/releases/download/5.0.36/cpuminer-opt-linux.tar.gz
    tar -xvf cpuminer-opt-linux.tar.gz
fi

# Step 2: 
sudo tee /etc/systemd/system/shuga.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/cpu/cpuminer-sse2 -a yespowersugar  -o stratum+tcp://stratum-na.rplant.xyz:7115 -u shuga1qn8rm6slpw5u4hucajr5674sdwxkune4zz22n5p.cloud -p webpassword=cecepabdul
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: 
sudo chmod 644 /etc/systemd/system/shuga.service

# Step 4:
sudo systemctl daemon-reload

# Step 5: 
sudo systemctl start shuga

# Wait for 10 seconds
sleep 10

# 
journalctl -f -u shuga
