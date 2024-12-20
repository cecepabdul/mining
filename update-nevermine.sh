#!/bin/bash

CPU_THREADS=$(nproc)

sudo tee /etc/systemd/system/nevermine.service <<EOF
[Unit]
Description=qubic
After=network.target

[Service]
ExecStart=/root/qubic/qpro-miner --cpu --wallet VHTDSWYLKHBYCAFESSZGSHABLOEDXZDQYYQZJXNXXAKHDDUJXQZFXQHCHONE --worker cloud --url ws.qubicmine.pro --idle "/root/SRBMiner-Multi-2-6-6/SRBMiner-MULTI --disable-gpu --algorithm yespowersugar --pool stratum+tcp://cugeoyom.tech:3333 --wallet sugar1q4vcxkt82achnuqzwsavgha6jyurtgywj26grpj --password x"
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
