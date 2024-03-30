#!/bin/bash

systemctl stop maza

# Step 2: Create systemd configuration file srb.service
sudo tee /etc/systemd/system/maza.service <<EOF
[Unit]
Description=SRBMiner-MULTI Service
After=network.target

[Service]
ExecStart=/root/SRBMiner-Multi-2-4-7/SRBMiner-MULTI --disable-gpu --algorithm minotaurx --pool stratum+tcp://minotaurx.na.mine.zpool.ca:7019 --wallet LYNzmqsz1rnfCkLiQisBHDkpWJE5YupiYd --password c=LTC,zap=MAZA
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF


# Step 4: Reload systemd configuration
sudo systemctl daemon-reload

# Step 5: Start the srb service
sudo systemctl start maza

# Wait for 10 seconds
sleep 10

# Check the status of the srb service
journalctl -f -u maza
