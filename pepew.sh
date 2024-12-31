#!/bin/bash

if [ ! -f "/root/SRBMiner-Multi-2-7-4/SRBMiner-MULTI" ]; then
    # File cpuminer doesn't exist, perform installation
    wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.7.4/SRBMiner-Multi-2-7-4-Linux.tar.gz
    tar -xvf SRBMiner-Multi-2-7-4-Linux.tar.gz
    cd SRBMiner-Multi-2-7-4
fi

# Step 2: Create systemd configuration file srb.service
sudo tee /etc/systemd/system/pepew.service <<EOF
[Unit]
Description=SRBMiner-MULTI Service
After=network.target

[Service]
ExecStart=/root/SRBMiner-Multi-2-7-4/SRBMiner-MULTI --disable-gpu --algorithm xelishashv2_pepew --pool stratum+tcp://us-cent.mining4people.com:4176 --wallet PRGbxfWBcVJ1Q1Tuinx6XhxExW2ME5JUat.cloud --password x
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Set permissions on the configuration file
sudo chmod 644 /etc/systemd/system/pepew.service

# Step 4: Reload systemd configuration
sudo systemctl daemon-reload

# Step 5: Start the srb service
sudo systemctl start pepew.service

# Wait for 10 seconds
sleep 10

# Check the status of the srb service
journalctl -fu pepew.service
