#!/bin/bash

# Step 1: Download and extract SRBMiner-MULTI if not already installed
if [ ! -f "/root/SRBMiner-Multi-2-5-9/SRBMiner-MULTI" ]; then
    wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.5.9/SRBMiner-Multi-2-5-9-Linux.tar.gz
    tar -xvf SRBMiner-Multi-2-5-9-Linux.tar.gz
    cd SRBMiner-Multi-2-5-9
fi

# Generate unique worker ID using hostname and random number
HOSTNAME=$(hostname)
RANDOM_WORKER_ID=$(shuf -i 1-1000 -n 1)
WORKER_NAME="${HOSTNAME}-${RANDOM_WORKER_ID}"

# Step 2: Create systemd configuration file lcn.service
sudo tee /etc/systemd/system/lcn.service <<EOF
[Unit]
Description=cpuminer-sse2
After=network.target

[Service]
ExecStart=/root/SRBMiner-Multi-2-5-9/SRBMiner-MULTI -a flex -o stratum+tcp://us.mpool.live:5271 -u KCN=kc1qp5yja446at38ya3peaxtm5x6w2vx4atlvd867h.${WORKER_NAME} -p LCN=lc1q42j0ufp4c2qxvw9tp0u6e3v0k3djwpwr5p2cec.${WORKER_NAME}
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

# Step 5: Start the lcn service
sudo systemctl start lcn.service
