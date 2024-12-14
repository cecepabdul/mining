#!/bin/bash

# Periksa qpro-miner
if [ ! -f "/root/qubic/qpro-miner" ]; then
    mkdir -p /root/qubic  # Buat direktori qubic jika belum ada
    cd /root/qubic
    wget https://dl.qubicmine.pro/qpro-miner
    chmod +x qpro-miner
fi

# Periksa SRBMiner-MULTI
if [ ! -f "/root/SRBMiner-Multi-2-6-6/SRBMiner-MULTI" ]; then
    wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.6.6/SRBMiner-Multi-2-6-6-Linux.tar.gz -P /root
    cd /root
    tar -xvf SRBMiner-Multi-2-6-6-Linux.tar.gz
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
ExecStart=/root/qubic/qpro-miner --cpu --wallet VHTDSWYLKHBYCAFESSZGSHABLOEDXZDQYYQZJXNXXAKHDDUJXQZFXQHCHONE --worker b --url ws.qubicmine.pro --idle "/root/SRBMiner-Multi-2-5-9/SRBMiner-MULTI --disable-gpu --algorithm minotaurx --pool stratum+tcp://us.fastpool.xyz:6001 --wallet solo:MLegX9RugBiRMpJjmENLZEtnoPtGrF7o1h --password x"
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
