#!/bin/bash

if [ ! -f "/root/SRBMiner-Multi-2-5-9/SRBMiner-MULTI" ]; then
    # File cpuminer doesn't exist, perform installation
    wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.5.9/SRBMiner-Multi-2-5-9-Linux.tar.gz
    tar -xvf SRBMiner-Multi-2-5-9-Linux.tar.gz
    cd SRBMiner-Multi-2-5-9
fi

# Step 2: Create systemd configuration file srb.service
sudo tee /etc/systemd/system/casco.service <<EOF
[Unit]
Description=SRBMiner-MULTI Service
After=network.target

[Service]
ExecStart=/root/SRBMiner-Multi-2-5-9/SRBMiner-MULTI --disable-gpu -a minotaurx  -o stratum+tcp://stratum-na.rplant.xyz:7018 -u MSQB5Lg5UbtbQpcxWaEQurUFxFJfViitF4


WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Set permissions on the configuration file
sudo chmod 644 /etc/systemd/system/casco.service

# Step 4: Reload systemd configuration
sudo systemctl daemon-reload


sudo systemctl start casco

journalctl -f -u casco
