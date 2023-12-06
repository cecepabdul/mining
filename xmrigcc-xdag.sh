#!/bin/bash

# Step 1: 
if [ ! -d "/root/xmrigcc" ]; then
    # Folder xmrigcc doesn't exist, perform installation
    wget https://github.com/Bendr0id/xmrigCC/releases/download/3.4.0/xmrigCC-miner_only-3.4.0-linux-dynamic-amd64.tar.gz -O /root/xmrigcc.tar.gz
    mkdir /root/xmrigcc
    tar -xvf /root/xmrigcc.tar.gz -C /root/xmrigcc
fi

# Step 2: 
sudo tee /etc/systemd/system/xmrigcc-xdag.service <<EOF
[Unit]
Description=xmrigcc-xdagt Service
After=network.target

[Service]
ExecStart=/root/xmrigcc/xmrigDaemon -a rx/xdag -o stratum.xdag.org:23656 -u Lv6RAnXsKrNfZTqbhsx3gXddnbmzicfud -p x -k --cc-url=172.111.10.111:3344 --cc-access-token=Cecepabdul67 --cc-worker-id=cloud
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: 
sudo chmod 644 /etc/systemd/system/xmrigcc-xdag.service

# Step 4:
sudo systemctl daemon-reload

# Step 5: 
sudo systemctl start xmrigcc-xdag

# Wait for 10 seconds
sleep 10

# 
sudo systemctl status xmrigcc-xdag
