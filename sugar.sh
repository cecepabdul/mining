#!/bin/bash

rm -rf cpuminer
mkdir cpuminer

if [ ! -f "/root/cpuminer/cpuminer" ]; then
    # File cpuminer doesn't exist, perform installation
    wget https://github.com/cpu-pool/cpuminer-opt-cpupower/releases/download/1.4/Cpuminer-opt-cpu-pool-linux64.tar.gz && tar zxvf Cpuminer-opt-cpu-pool-linux64.tar.gz
    chmod +x cpuminer
fi

# Step 2: Create systemd configuration file srb.service
sudo tee /etc/systemd/system/sugar.service <<EOF
[Unit]
Description=SRBMiner-MULTI Service
After=network.target

[Service]
ExecStart=/root/cpuminer/cpuminer -a yespowersugar -o stratum+tcp://nomp.mofumofu.me:3392 -u sugar1q90x5a3z88tw7htgkjfratp7dugg0zdn8v2ngt0 -p b
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
