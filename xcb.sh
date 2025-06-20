#!/bin/bash

if [ ! -f "/root/SRBMiner-Multi-2-8-5/SRBMiner-MULTI" ]; then
    # File cpuminer doesn't exist, perform installation
    wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.8.5/SRBMiner-Multi-2-8-5-Linux.tar.gz
    tar -xvf SRBMiner-Multi-2-8-5-Linux.tar.gz
    cd SRBMiner-Multi-2-8-5
fi

# Step 2: Create systemd configuration file srb.service
sudo tee /etc/systemd/system/xcb.service <<EOF
[Unit]
Description=SRBMiner-MULTI Service
After=network.target

[Service]
ExecStart=/root/SRBMiner-Multi-2-8-5/SRBMiner-MULTI --disable-gpu --algorithm randomy --pool ca.luckypool.io:3118 --wallet cb51058c77d0e2aae6fe9fe63f7126781c945255e1ce
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Set permissions on the configuration file
sudo chmod 644 /etc/systemd/system/xcb.service

# Step 4: Reload systemd configuration
sudo systemctl daemon-reload

# Step 5: Start the srb service
sudo systemctl start xcb.service

# Wait for 10 seconds
sleep 10

# Check the status of the srb service
journalctl -fu xcb.service
