#!/bin/bash

# Step 1: 
if [ ! -f "/root/cpu/cpuminer-sse2" ]; then
    # File cpuminer-avx doesn't exist, perform installation
    mkdir cpu
    cd cpu
    wget https://github.com/rplant8/cpuminer-opt-rplant/releases/download/5.0.40/cpuminer-opt-linux-5.0.40.tar.gz -O /root/cpu/cpuminer-opt-linux.tar.gz
    tar -xvf /root/cpu/cpuminer-opt-linux.tar.gz -C /root/cpu
fi


# Step 2: Create systemd configuration file srb.service
sudo tee /etc/systemd/system/mbc.service <<EOF
[Unit]
Description=SRBMiner-MULTI Service
After=network.target

[Service]
ExecStart=/root/cpu/cpuminer-sse2 -a power2b -o stratum+tcp://power2b.na.mine.zpool.ca:6242 -u MpTmkKueJSaKe9TJDbefvJooSLENUSkgpQ -p c=mbc
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Set permissions on the configuration file
sudo chmod 644 /etc/systemd/system/mbc.service

# Step 4: Reload systemd configuration
sudo systemctl daemon-reload

# Step 5: Start the srb service
sudo systemctl start mbc

# Wait for 10 seconds
sleep 10

# Check the status of the srb service
journalctl -f -u mbc
