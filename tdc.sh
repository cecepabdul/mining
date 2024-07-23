#!/bin/bash

rm -rf cpu
mkdir cpu
cd cpu

# Step 1: 
if [ ! -f "/root/cpuminer-sse2" ]; then
    # File cpuminer-avx doesn't exist, perform installation
    wget https://github.com/rplant8/cpuminer-opt-rplant/releases/download/5.0.40/cpuminer-opt-linux-5.0.40.tar.gz -O /root/cpu/cpuminer-opt-linux.tar.gz
    tar -xvf /root/cpu/cpuminer-opt-linux.tar.gz -C /root/cpu
fi

# Step 2: 
sudo tee /etc/systemd/system/tdc.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/cpuminer-sse2 -a yespowertide  -o stratum+tcp://stratum-na.rplant.xyz:7059 -u TEamxYU9QWLwNbfSt2jBww2Pd8oZdcdJ5Z.b -p webpassword=cecepabdul
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: 
sudo chmod 644 /etc/systemd/system/tdc.service

# Step 4:
sudo systemctl daemon-reload

# Step 5: 
sudo systemctl start tdc

# Wait for 10 seconds
sleep 10

# 
journalctl -f -u tdc
