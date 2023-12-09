#!/bin/bash

# Step 1: 
if [ ! -f "/root/cpuminer-sse2" ]; then
    # File cpuminer-avx doesn't exist, perform installation
    wget https://github.com/rplant8/cpuminer-opt-rplant/releases/download/5.0.24/cpuminer-opt-linux.tar.gz -O /root/cpuminer-opt-linux.tar.gz
    tar -xvf /root/cpuminer-opt-linux.tar.gz -C /root
fi

# Step 2: 
sudo tee /etc/systemd/system/sugar.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/./cpuminer-sse2 -a yespowersugar -o stratum+tcp://stratum-na.rplant.xyz:7042 -u sugar1q4vcxkt82achnuqzwsavgha6jyurtgywj26grpj.b -p webpassword=cecepabdul
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: 
sudo chmod 644 /etc/systemd/system/sugar.service

# Step 4:
sudo systemctl daemon-reload

# Step 5: 
sudo systemctl start sugar

# Wait for 10 seconds
sleep 10

# 
sudo systemctl status sugar
