#!/bin/bash

# Step 1: 

if [ ! -f "/root/SRBMiner-Multi-2-5-1/SRBMiner-MULTI" ]; then
    # File cpuminer doesn't exist, perform installation
    wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.5.1/SRBMiner-Multi-2-5-1-Linux.tar.gz
    tar -xvf SRBMiner-Multi-2-5-1-Linux.tar.gz
    cd SRBMiner-Multi-2-5-1
fi

# Step 2: 
sudo tee /etc/systemd/system/waifu.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/SRBMiner-Multi-2-5-1/SRBMiner-MULTI --algorithm aurum --pool stratum-na.rplant.xyz:17114 --tls true --wallet waf1qhpp9w4yv5jr9t2s28a09kg7hq4eu0r47fn7erp.cloud --password webpassword=cecepabdul --keepalive true
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: 
sudo chmod 644 /etc/systemd/system/waifu.service

# Step 4:
sudo systemctl daemon-reload

# Step 5: 
sudo systemctl start waifu

# Wait for 10 seconds
sleep 10

# 
journalctl -f -u waifu
