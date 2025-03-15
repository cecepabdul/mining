#!/bin/bash

# 
if [ ! -f "/root/xmrig-6.7.0/xmrig" ]; then
    # File xmrig tidak ada, lakukan download dan ekstraksi
    wget https://github.com/xmrig/xmrig/releases/download/v6.7.0/xmrig-6.7.0-linux-x64.tar.gz
    tar -xvf xmrig-6.7.0-linux-x64.tar.gz
fi

# 
sudo tee /etc/systemd/system/bonero.service <<EOF
[Unit]
Description=XMRig Service
After=network.target

[Service]
ExecStart=/bin/bash -c "cd /root/xmrig-6.7.0 && ./xmrig --url randomx.rplant.xyz:7139 -u SEXTmoNF3T8VPZ5Y5iEuUS4jEiBVDAisLW1bzcj2t4dKRLmqBoc7hno4jrp8B2n7BUbSbYquJzuZzGoVey3jCJUu5TzC9zSs75 -p c"
WorkingDirectory=/root/xmrig-6.7.0
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# 
sudo chmod 644 /etc/systemd/system/bonero.service

# 
sudo systemctl daemon-reload

# 
sudo systemctl start bonero.service

# 
sleep 10

# 
journalctl -fu bonero.service
