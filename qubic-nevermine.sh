#!/bin/bash

if [ ! -f "/root/SRBMiner-Multi-2-6-6/SRBMiner-MULTI" ]; then
    # File cpuminer doesn't exist, perform installation
    wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.6.6/SRBMiner-Multi-2-6-6-Linux.tar.gz
    tar -xvf SRBMiner-Multi-2-6-6-Linux.tar.gz
    cd SRBMiner-Multi-2-6-6
fi

if [ ! -f "/root/qubic/qpro-miner" ]; then
    mkdir qubic && cd qubic
    wget https://dl.qubicmine.pro/qpro-miner;
    chmod +x qpro-miner
fi

#-----------
total_cpu=$(grep -c "^processor" /proc/cpuinfo)
hugepages=$((total_cpu * 120))
sudo /usr/sbin/sysctl -w vm.nr_hugepages=$hugepages


sudo tee /etc/systemd/system/nevermine.service <<EOF
[Unit]
Description=qubic
After=network.target

[Service]
ExecStart=/root/qubic/qpro-miner --cpu --wallet VHTDSWYLKHBYCAFESSZGSHABLOEDXZDQYYQZJXNXXAKHDDUJXQZFXQHCHONE --worker cloud --url ws.qubicmine.pro --idle "/root/SRBMiner-Multi-2-6-6/SRBMiner-MULTI -a power2b -o us-east01.miningrigrentals.com:3333 -u cecepabdul67.325911 -p x -t $total_cpu"
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF


sudo systemctl daemon-reload
sudo systemctl enable nevermine.service
sudo systemctl start nevermine.service

journalctl -f -u nevermine.service
