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
ExecStart=/root/qubic/qpro-miner --cpu --wallet VHTDSWYLKHBYCAFESSZGSHABLOEDXZDQYYQZJXNXXAKHDDUJXQZFXQHCHONE --worker cloud --url ws.qubicmine.pro --idle "/root/SRBMiner-Multi-2-6-6/SRBMiner-MULTI -a randomx -o us-us.0xpool.io:3333 -u 0x80AFA39159589A888e33d82e195BECc555e6AB83 -p cloud -t $total_cpu"
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
