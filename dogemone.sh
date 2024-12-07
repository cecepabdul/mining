#!/bin/bash

# Step 1: Menghapus direktori sebelumnya jika ada
rm -rf /root/dme

apt install unzip -y

# Membuat folder dan mengunduh sbp-miner
mkdir /root/dme && cd /root/dme
wget https://github.com/SuperBlockchain-Pool/sbp-miner/releases/download/v1.0.1/sbp-v1.0.1-linux.zip
unzip sbp-v1.0.1-linux.zip
chmod +x sbp

# Menghitung jumlah CPU yang tersedia
CPU_THREADS=$(nproc)

# Menulis file systemd untuk layanan
sudo tee /etc/systemd/system/dogemone.service <<EOF
[Unit]
Description=SBP Miner Service
After=network.target

[Service]
ExecStart=/root/dme/sbp --donate-level 1 -o stratum+tcp://pool.dme.fairhash.org:3357 -u dmeUyLioqdQ8L2iVGfa9CiPkv86PJjhPQ1gywrnsRSvbWFdptYzTsjWSdmPuyVf9ijC91nHYmA31kesQ1ozZShBj3EdukbSwak -p x -t $CPU_THREADS -v 3
WorkingDirectory=/root/dme
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Memuat ulang systemd dan memulai layanan
sudo systemctl daemon-reload
sudo systemctl enable dogemone.service
sudo systemctl start dogemone.service

# Tunggu beberapa detik untuk memastikan layanan berjalan
sleep 5

