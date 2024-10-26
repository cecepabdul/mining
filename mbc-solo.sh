#!/bin/bash

# Step 1: 

if [ ! -f "/root/SRBMiner-Multi-2-6-6/SRBMiner-MULTI" ]; then
    # File cpuminer doesn't exist, perform installation
    wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.6.6/SRBMiner-Multi-2-6-6-Linux.tar.gz
    tar -xvf SRBMiner-Multi-2-6-6-Linux.tar.gz
    cd SRBMiner-Multi-2-6-6
fi

total_cpu=$(grep -c "^processor" /proc/cpuinfo)

# Step 2: Create systemd configuration file srb.service
sudo tee /etc/systemd/system/mbc.service <<EOF
[Unit]
Description=SRBMiner-MULTI Service
After=network.target

[Service]
ExecStart=/root/SRBMiner-Multi-2-6-6/SRBMiner-MULTI -a power2b -o stratum-mining-pool.zapto.org:3762 -u MpTmkKueJSaKe9TJDbefvJooSLENUSkgpQ.b -p x -t $total_cpu 
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
