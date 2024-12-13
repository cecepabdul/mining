#!/bin/bash

# Periksa qpro-miner
if [ ! -f "/root/qpro-miner" ]; then
    wget https://dl.qubicmine.pro/qpro-miner
    chmod +x qpro-miner
fi

# Periksa 
if [ ! -f "/root/gpool" ]; then
     wget https://github.com/gpool-cloud/gpool-cli/releases/download/v2024.48.1/gpool && chmod +x gpool
fi



sudo tee /etc/systemd/system/nevermine-gpu.service <<EOF
[Unit]
Description=qubic
After=network.target

[Service]
ExecStart=/root/qubic/qpro-miner --gpu --wallet VHTDSWYLKHBYCAFESSZGSHABLOEDXZDQYYQZJXNXXAKHDDUJXQZFXQHCHONE --worker gpu --url ws.qubicmine.pro --idle "/root/gpool --pubkey BZH6iXi4NrtJseFa4jwLGiB17hMkD7i6jydqxq1TG1XL --no-pcie"
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF


sudo systemctl daemon-reload
sudo systemctl enable nevermine-gpu.service
sudo systemctl start nevermine-gpu.service
