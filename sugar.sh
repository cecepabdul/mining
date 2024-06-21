#!/bin/bash

if [ ! -f "/root/SRBMiner-Multi-2-4-7/SRBMiner-MULTI" ]; then
    # File cpuminer doesn't exist, perform installation
    wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.4.7/SRBMiner-Multi-2-4-7-Linux.tar.xz
    tar -xvf SRBMiner-Multi-2-4-7-Linux.tar.xz
    cd SRBMiner-Multi-2-4-7
fi

# Step 2: Create systemd configuration file srb.service
sudo tee /etc/systemd/system/sugar.service <<EOF
[Unit]
Description=SRBMiner-MULTI Service
After=network.target

[Service]
ExecStart=/root/SRBMiner-Multi-2-4-7/SRBMiner-MULTI --disable-gpu --algorithm yespowersugar --pool stratum+tcp://yespowerSUGAR.na.mine.zergpool.com:6535 --wallet TZGQwQ58mdfVg5Tr7ap91pDq4GGARtGYrj --password c=TRX,mc=SUGAR,m=solo,ID=cloud
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Set permissions on the configuration file
sudo chmod 644 /etc/systemd/system/sugar.service

# Step 4: Reload systemd configuration
sudo systemctl daemon-reload

# Step 5: Start the srb service
sudo systemctl start sugar.service

# Wait for 10 seconds
sleep 10

# Check the status of the srb service
journalctl -f -u sugar.service
