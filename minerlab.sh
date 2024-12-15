#!/bin/bash

mkdir minerlab
cd minerlab

wget https://dl.qubic.li/downloads/qli-Client-3.1.1-Linux-x64.tar.gz && tar -xvf qli-Client-3.1.1-Linux-x64.tar.gz && rm qli-Client-3.1.1-Linux-x64.tar.gz && rm appsettings.json
curl -L -o appsettings.json https://github.com/abdul66777/qubic/raw/refs/heads/main/pps-minerlab.json


sudo tee /etc/systemd/system/minerlab.service <<EOF
[Unit]
Description=qubic
After=network.target

[Service]
ExecStart=/root/minerlab/./qli-Client
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF


sudo systemctl daemon-reload
sudo systemctl start minerlab.service

journalctl -f -u minerlab.service
