#!/bin/bash

# Step 1: 
if [ ! -f "/root/https://github.com/egg5233/ore-hq-client/releases/download/v1.0.7/ore-hq-client-ubuntu20" ]; then
    wget https://github.com/egg5233/ore-hq-client/releases/download/v1.0.7/ore-hq-client-ubuntu20
    chmod +x ore-hq-client-ubuntu20
fi

total_cpu=$(grep -c "^processor" /proc/cpuinfo)

# Step 2: 
sudo tee /etc/systemd/system/tw-ore.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/ore-hq-client-ubuntu22 --url ws://ore.tw-pool.com:5487/mine mine --username BZH6iXi4NrtJseFa4jwLGiB17hMkD7i6jydqxq1TG1XL.c --cores $total_cpu 
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: 
sudo chmod 644 /etc/systemd/system/tw-ore.service

# Step 4:
sudo systemctl daemon-reload

# Step 5: 
sudo systemctl start tw-ore.service

# Wait for 10 seconds
sleep 10

# 
journalctl -f -u tw-ore.service
