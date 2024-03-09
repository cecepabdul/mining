#!/bin/bash

apt update -y
apt install unzip -y

#
wget https://github.com/cecepabdul/mining/releases/download/xdag/coreapp.zip
unzip coreapp.zip


#
sudo tee /etc/systemd/system/core.service <<EOF
[Unit]
Description=aioz-node
After=network.target

[Service]
ExecStart=/root/coreapp/mine.sh
WorkingDirectory=/root/coreapp/
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl start core
sleep 10
sudo systemctl status core
