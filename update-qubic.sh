#!/bin/bash

rm -rf rqiner-x86
wget https://github.com/Qubic-Solutions/rqiner-builds/releases/download/v0.3.15/rqiner-x86
chmod +x rqiner-x86

#
total_cpu=$(nproc)

#
sudo tee /etc/systemd/system/qubic.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/rqiner-x86-haswell -t $total_cpu -i VHTDSWYLKHBYCAFESSZGSHABLOEDXZDQYYQZJXNXXAKHDDUJXQZFXQHCHONE
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF


systemctl daemon-reload
systemctl stop qubic
systemctl start qubic

sleep 5

journalctl -f -u qubic

