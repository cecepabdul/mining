#!/bin/bash

if [ ! -f "/root/SRBMiner-Multi-2-4-7/SRBMiner-MULTI" ]; then
    # File cpuminer doesn't exist, perform installation
    wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.4.7/SRBMiner-Multi-2-4-7-Linux.tar.xz
    tar -xvf SRBMiner-Multi-2-4-7-Linux.tar.xz
    cd SRBMiner-Multi-2-4-7
fi

# Step 2: Create systemd configuration file srb.service
sudo tee /etc/systemd/system/maza-aika.service <<EOF
[Unit]
Description=SRBMiner-MULTI Service
After=network.target

[Service]
ExecStart=/root/SRBMiner-Multi-2-4-7/SRBMiner-MULTI --disable-gpu --algorithm minotaurx --pool stratum.aikapool.com:3904 --wallet abdul67.bare --password x
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Set permissions on the configuration file
sudo chmod 644 /etc/systemd/system/maza-aika.service

# Step 4: Reload systemd configuration
sudo systemctl daemon-reload

# Step 5: Start the srb service
sudo systemctl start maza-aika

# Wait for 10 seconds
sleep 10

# Check the status of the srb service
journalctl -f -u maza-aika
