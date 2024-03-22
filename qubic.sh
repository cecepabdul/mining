#!/bin/bash

# Step 1: 
if [ ! -f "/root/rqiner-x86" ]; then
    # File cpuminer-avx doesn't exist, perform installation
    wget https://github.com/Qubic-Solutions/rqiner-builds/releases/download/v0.3.14/rqiner-x86 && chmod +x rqiner-x86
fi

# Step 2: 
# Mendapatkan jumlah CPU yang tersedia
total_cpu=$(nproc)

# Menjalankan perintah dengan argumen -t sesuai dengan jumlah CPU
sudo tee /etc/systemd/system/qubic.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/rqiner-x86 -t $total_cpu -i VHTDSWYLKHBYCAFESSZGSHABLOEDXZDQYYQZJXNXXAKHDDUJXQZFXQHCHONE
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: 
sudo chmod 644 /etc/systemd/system/qubic.service

# Step 4:
sudo systemctl daemon-reload

# Step 5: 
sudo systemctl start qubic.service

# Wait for 10 seconds
sleep 10

# 
journalctl -f -u qubic
