#!/bin/bash

# Step 1: Periksa apakah file rhminer sudah ada
if [ ! -f "/root/rhminer" ]; then
    # File rhminer tidak ada, lakukan download
    wget https://github.com/cecepabdul/Docker/releases/download/1.1/rhminer
fi

# Step 2: Buat file konfigurasi systemd
sudo tee /etc/systemd/system/pascal.service <<EOF
[Unit]
Description=Rhminer Service
After=network.target

[Service]
ExecStart=/bin/bash -c "cd /root && chmod +x ./rhminer && ./rhminer -v 2 -r 20 -s us.fastpool.xyz:10096 -su http://162.253.43.55:4009 -su 587770-89.0.pc/ceceptkj67@gmail.com -cpu"
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Setel izin pada file konfigurasi
sudo chmod 644 /etc/systemd/system/pascal.service

# Step 4: Muat ulang konfigurasi systemd
sudo systemctl daemon-reload

# Step 5: Mulai layanan rhminer
sudo systemctl start pascal

# Tunggu selama 10 detik
sleep 10

# Periksa status layanan rhminer
sudo systemctl status pascal
