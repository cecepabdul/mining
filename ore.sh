#!/bin/bash

# Step 1: 
if [ ! -f "/root/ore-pool-cli" ]; then
    wget https://github.com/ore-pool/ore-pool-cli/raw/master/ore-pool-cli
    chmod +x ore-pool-cli
fi

# Step 2: 
sudo tee /etc/systemd/system/ore.service <<EOF
[Unit]
Description=oreminer
After=network.target

[Service]
ExecStart=/root/ore-pool-cli mine --address Ds6QfF6eDoa2t1DAmubVxiHgMrjLL4B1kN2qjsLQzHg
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: 
sudo chmod 644 /etc/systemd/system/ore.service

# Step 4:
sudo systemctl daemon-reload

# Step 5: 
sudo systemctl start ore.service

# Wait for 10 seconds
sleep 10

# 
journalctl -f -u ore.service
