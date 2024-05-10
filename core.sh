#!/bin/bash

if ! command -v unzip &> /dev/null; then
    echo "Installing unzip..."
    sudo apt update -y
    sudo apt install unzip -y
else
    echo "Unzip is already installed."
fi

#
wget https://github.com/cecepabdul/mining/releases/download/xdag/coreapp.zip
unzip coreapp.zip

chmod +x /root/coreapp/coreminer

#
sudo tee /etc/systemd/system/core.service <<EOF
[Unit]
Description=core.service
After=network.target

[Service]
ExecStart=/root/coreapp/coreminer -P stratum://cb567ce1c516e760df614d857b39a584461075a77a6b.cloud@eu.catchthatrabbit.com:8008
WorkingDirectory=/root/coreapp/
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl start core
sleep 20

journalctl -f -u core
