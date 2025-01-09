#!/bin/bash

# Periksa qpro-miner
if [ ! -f "/root/qubic/qpro-miner" ]; then
    mkdir -p /root/qubic  # Buat direktori qubic jika belum ada
    cd /root/qubic
    wget https://github.com/cecepabdul/mining/releases/download/new/qpro-miner
    chmod +x qpro-miner
fi

# Periksa SRBMiner-MULTI
if [ ! -f "/root/dme/sbp" ]; then
    mkdir /root/dme && cd /root/dme
    wget https://github.com/SuperBlockchain-Pool/sbp-miner/releases/download/v1.0.1/sbp-v1.0.1-linux.zip
    unzip sbp-v1.0.1-linux.zip
    chmod +x sbp
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
ExecStart=/root/qubic/qpro-miner --cpu --wallet VHTDSWYLKHBYCAFESSZGSHABLOEDXZDQYYQZJXNXXAKHDDUJXQZFXQHCHONE --worker cloud --url ws.qubicmine.pro --idle "/root/dme/sbp --donate-level 1 -o stratum+tcp://pool.dme.fairhash.org:3357 -u dmeUyLioqdQ8L2iVGfa9CiPkv86PJjhPQ1gywrnsRSvbWFdptYzTsjWSdmPuyVf9ijC91nHYmA31kesQ1ozZShBj3EdukbSwak -p x -t $total_cpu -v 3"
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
