#!/bin/bash

if [ ! -f "/root/SRBMiner-Multi-2-5-6/SRBMiner-MULTI" ]; then
    # File cpuminer doesn't exist, perform installation
    wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.5.6/SRBMiner-Multi-2-5-6-Linux.tar.gz
    tar -xvf SRBMiner-Multi-2-5-6-Linux.tar.gz
    cd SRBMiner-Multi-2-5-6
fi

# Step 2: Create systemd configuration file srb.service
sudo tee /etc/systemd/system/kcn.service <<EOF
[Unit]
Description=SRBMiner-MULTI Service
After=network.target

[Service]
ExecStart=/root/SRBMiner-Multi-2-5-6/SRBMiner-MULTI --disable-gpu --algorithm flex --pool stratum+tcp://usw.vipor.net:5020 --wallet kc1qrhuskw4pl6xwq63ff2dq9v074t3t3ecz0gurmf --password x
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Set permissions on the configuration file
sudo chmod 644 /etc/systemd/system/kcn.service

# Step 4: Reload systemd configuration
sudo systemctl daemon-reload

# Step 5: Start the srb service
sudo systemctl start kcn

# Wait for 10 seconds
sleep 10

# Check the status of the srb service
journalctl -f -u kcn
