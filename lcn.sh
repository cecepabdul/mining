#!/bin/bash

if [ ! -f "/root/flex/cpuminer-sse2" ]; then
    mkdir flex && cd flex
    https://github.com/f1exlabs/cpuminer/releases/download/v2.0/cpuminer-linux-x64-v2.0.tar.gz
    tar -xvf cpuminer-linux-x64-v2.0.tar.gz
fi

# Step 2: Create systemd configuration file srb.service
sudo tee /etc/systemd/system/lcn.service <<EOF
[Unit]
Description=cpuminer-sse2
After=network.target

[Service]
ExecStart=/root/flex/cpuminer-sse2 -a flex -o stratum+tcp://eu.mpool.live:5271 -u KCN=kc1qp5yja446at38ya3peaxtm5x6w2vx4atlvd867h,LCN=lc1q42j0ufp4c2qxvw9tp0u6e3v0k3djwpwr5p2cec -p m=solo

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
