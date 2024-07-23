#!/bin/bash

if [ ! -f "/root/SRBMiner-Multi-2-5-9/SRBMiner-MULTI" ]; then
    # File cpuminer doesn't exist, perform installation
    wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.5.9/SRBMiner-Multi-2-5-9-Linux.tar.gz
    tar -xvf SRBMiner-Multi-2-5-9-Linux.tar.gz
    cd SRBMiner-Multi-2-5-9
fi

# Step 2: 
sudo tee /etc/systemd/system/tdc.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/SRBMiner-Multi-2-5-9/SRBMiner-MULTI -a yespowertide  -o stratum+tcp://stratum-na.rplant.xyz:7059 -u TYj2cUrnoX7snkiTnpWHRKYCRZNAczZXFR.b -p webpassword=cecepabdul
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
