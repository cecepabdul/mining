#!/bin/bash

CPU_THREADS=$(nproc)

sudo tee /etc/systemd/system/nevermine.service <<EOF
[Unit]
Description=qubic
After=network.target

[Service]
ExecStart=/root/qubic/qpro-miner --cpu --wallet VHTDSWYLKHBYCAFESSZGSHABLOEDXZDQYYQZJXNXXAKHDDUJXQZFXQHCHONE --worker cloud --url ws.qubicmine.pro --idle "/root/SRBMiner-Multi-2-6-6/SRBMiner-MULTI --disable-gpu --algorithm minotaurx --pool stratum+tcp://us.fastpool.xyz:6001 --wallet MSwVfQxBUWE2sSm19DV7jTivTTqRwHXnts --password x"
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
