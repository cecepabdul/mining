#!/bin/bash
# Step 1: 
rm -rf rieMiner

mkdir rieMiner && cd rieMiner
wget https://github.com/cecepabdul/mining/releases/download/xdag/rieminer
wget https://raw.githubusercontent.com/cecepabdul/mining/main/rieMiner.conf
chmod +x rieminer

sudo tee /etc/systemd/system/rieminer.service <<EOF
[Unit]
Description=rieminer Service
After=network.target

[Service]
ExecStart=/root/rieMiner/rieminer
WorkingDirectory=/root/rieMiner/
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start rieminer

sleep 5
journalctl -f -u rieminer
