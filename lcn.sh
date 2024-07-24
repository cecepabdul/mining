#!/bin/bash

if [ ! -f "/root/SRBMiner-Multi-2-5-9/SRBMiner-MULTI" ]; then
    # File cpuminer doesn't exist, perform installation
    wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.5.9/SRBMiner-Multi-2-5-9-Linux.tar.gz
    tar -xvf SRBMiner-Multi-2-5-9-Linux.tar.gz
    cd SRBMiner-Multi-2-5-9
fi

# Step 2: Create systemd configuration file srb.service
sudo tee /etc/systemd/system/lcn.service <<EOF
[Unit]
Description=SRBMiner-MULTI Service
After=network.target

[Service]
ExecStart=/root/SRBMiner-Multi-2-5-9/SRBMiner-MULTI -a flex -o stratum+ssl://eu.mpool.live:5213 -u LCN=lc1q42j0ufp4c2qxvw9tp0u6e3v0k3djwpwr5p2cec -p m=solo

WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Set permissions on the configuration file
sudo chmod 644 /etc/systemd/system/lcn.service

# Step 4: Reload systemd configuration
sudo systemctl daemon-reload

# Step 5: Start the srb service
sudo systemctl start lcn.service

# Wait for 10 seconds
sleep 10

# Check the status of the srb service
journalctl -f -u lcn.service
