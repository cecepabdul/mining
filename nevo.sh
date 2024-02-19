#!/bin/bash

# Step 1: Periksa apakah file xmrig sudah ada
if [ ! -f "/root/nevorig-v6.20.0-x86_64-linux-gnu" ]; then
    # File xmrig tidak ada, lakukan download dan ekstraksi
    wget https://github.com/nevocoin/NEVORig/releases/download/v6.20.0/nevorig-v6.20.0-x86_64-linux-gnu.tar.xz
    tar -xvf nevorig-v6.20.0-x86_64-linux-gnu.tar.xz
fi

# Step 2: Buat file konfigurasi systemd
sudo tee /etc/systemd/system/nevo.service <<EOF
[Unit]
Description=nevo Service
After=network.target

[Service]
ExecStart=/bin/bash -c "cd /root/nevorig-v6.20.0-x86_64-linux-gnu/ && chmod +x ./xmrig && ./xmrig -k -a rx/nevo --donate-level 1 -o nevocoin.ch:2052 -u NS2KMCKhpLSbz2RtKSLy92VRyzpbny6BfcX9uLLP3EsAF4rHQUGNtHbX6Uytbodj88b9tfUWzUebiXVyn2ZaFAqS13aSkdj67 -p cloud"
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Setel izin pada file konfigurasi
sudo chmod 644 /etc/systemd/system/nevo.service

# Step 4: Muat ulang konfigurasi systemd
sudo systemctl daemon-reload

# Step 5: Mulai layanan xmrig
sudo systemctl start nevo

# Tunggu selama 10 detik
sleep 10

# Periksa status layanan xmrig
sudo systemctl status nevo
