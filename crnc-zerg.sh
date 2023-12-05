#!/bin/bash

# Step 1: 
if [ ! -f "/root/cpuminer-sse2" ]; then
    # File cpuminer-avx doesn't exist, perform installation
    wget https://github.com/rplant8/cpuminer-opt-rplant/releases/download/5.0.24/cpuminer-opt-linux.tar.gz -O /root/cpuminer-opt-linux.tar.gz
    tar -xvf /root/cpuminer-opt-linux.tar.gz -C /root
fi

# Step 2: 
sudo tee /etc/systemd/system/crnc-zerg.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/cpuminer-sse2 -a yespowerltncg -o stratum+tcp://yespowerLTNCG.mine.zergpool.com:6239 -u  TZGQwQ58mdfVg5Tr7ap91pDq4GGARtGYrj -p c=TRX,mc=CRNC/LNCR"
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: 
sudo chmod 644 /etc/systemd/system/crnc-zerg.service

# Step 4:
sudo systemctl daemon-reload

# Step 5: 
sudo systemctl start crnc-zerg

# Wait for 10 seconds
sleep 10

# 
sudo systemctl status crnc-zerg
