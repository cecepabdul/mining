#!/bin/bash


# Menghitung jumlah CPU yang tersedia
CPU_THREADS=$(nproc)

# Menulis file systemd untuk layanan
sudo tee /etc/systemd/system/dogemone.service <<EOF
[Unit]
Description=SBP Miner Service
After=network.target

[Service]
ExecStart=/root/dme/sbp -o stratum+tcp://pool.dme.fairhash.org:3357 -u solo:dmeUyLioqdQ8L2iVGfa9CiPkv86PJjhPQ1gywrnsRSvbWFdptYzTsjWSdmPuyVf9ijC91nHYmA31kesQ1ozZShBj3EdukbSwak -p x -t $CPU_THREADS -v 3
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
