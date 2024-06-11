#!/bin/bash

if [ ! -f "/root/hellminer" ]; then
    # File cpuminer doesn't exist, perform installation
    wget https://github.com/hellcatz/hminer/releases/download/v0.59.1/hellminer_linux64.tar.gz
    tar -xvf hellminer_linux64.tar.gz
    chmod +x hellminer
fi

# Step 2: Create systemd configuration file srb.service
sudo tee /etc/systemd/system/verus.service <<EOF
[Unit]
Description=SRBMiner-MULTI Service
After=network.target

[Service]
ExecStart=/root/hellminer -c stratum+tcp://cn.vipor.net:5040 -u REwKqDLJyP2BZnvnw4rm9yCGWEEE8pkVHA.cloud -p x
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Set permissions on the configuration file
sudo chmod 644 /etc/systemd/system/verus.service

# Step 4: Reload systemd configuration
sudo systemctl daemon-reload

# Step 5: Start the srb service
sudo systemctl start verus.service

# Wait for 10 seconds
sleep 10

# Check the status of the srb service
journalctl -f -u verus.service
