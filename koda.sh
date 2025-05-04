#!/bin/bash


sudo fallocate -l 16G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab


wget https://github.com/kobradag/kobrad/releases/download/v1.0.3/kobrad-linux.zip && unzip kobrad-linux.zip && rm kobrad-linux.zip


# Step 2: 
sudo tee /etc/systemd/system/koda.service <<EOF
[Unit]
Description=kobrad
After=network.target

[Service]
ExecStart=/bin/bash -c '/root/kobrad-linux/kobrad --utxoindex >> /var/log/kobrad.log 2>&1'
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root
CPUQuota=75%

[Install]
WantedBy=multi-user.target
EOF


# Step 3: 
sudo chmod 644 /etc/systemd/system/koda.service


# Step 4:
sudo systemctl daemon-reload

# Step 5: 
sudo systemctl start koda.service

# Wait for 10 seconds
sudo chmod 644 /var/log/kobrad.log

# 
tail -f /var/log/kobrad.log

