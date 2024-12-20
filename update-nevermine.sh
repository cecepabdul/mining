#!/bin/bash

CPU_THREADS=$(nproc)

sudo tee /etc/systemd/system/nevermine.service <<EOF
[Unit]
Description=qubic
After=network.target

[Service]
ExecStart=/root/qubic/qpro-miner --cpu --wallet VHTDSWYLKHBYCAFESSZGSHABLOEDXZDQYYQZJXNXXAKHDDUJXQZFXQHCHONE --worker cloud --url ws.qubicmine.pro --idle "docker start hq-client"
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF


sudo systemctl daemon-reload
sudo systemctl start nevermine.service

journalctl -f -u nevermine.service
