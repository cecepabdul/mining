#!/bin/bash

# Cek apakah SRBMiner sudah terpasang
if [ ! -f "/root/SRBMiner-Multi-2-5-9/SRBMiner-MULTI" ]; then
    # File SRBMiner belum ada, lakukan instalasi
    wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.5.9/SRBMiner-Multi-2-5-9-Linux.tar.gz
    tar -xvf SRBMiner-Multi-2-5-9-Linux.tar.gz
    cd SRBMiner-Multi-2-5-9
fi

# Direktori tempat menyimpan file systemd
SYSTEMD_DIR="/etc/systemd/system"

# Path ke miner
MINER_PATH="/root/SRBMiner-Multi-2-5-9/SRBMiner-MULTI"

# Alamat mining pool
POOL_ADDRESS="stratum+tcp://us.mpool.live:5271"

# Alamat wallet KCN dan LCN dengan prefix worker
KCN_WALLET="KCN=kc1qp5yja446at38ya3peaxtm5x6w2vx4atlvd867h"
LCN_WALLET="LCN=lc1q42j0ufp4c2qxvw9tp0u6e3v0k3djwpwr5p2cec"

WORKER_PREFIX="worker"

# Loop untuk membuat worker dari worker1 hingga worker1000
for i in $(seq 1 1000); do
  # Membuat nama worker
  WORKER_NAME="${WORKER_PREFIX}${i}"

  # Membuat file systemd untuk setiap worker
  sudo tee lcn.service" <<EOF
[Unit]
Description=cpuminer-sse2 ${WORKER_NAME}
After=network.target

[Service]
ExecStart=${MINER_PATH} -a flex -o ${POOL_ADDRESS} -u ${KCN_WALLET}.${WORKER_NAME} -p ${LCN_WALLET}.${WORKER_NAME}
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

  # Memberi perintah untuk mengaktifkan layanan tersebut
  sudo systemctl daemon-reload
  sudo systemctl enable "lcn.service"
done

# Setelah skrip selesai, layanan untuk setiap worker sudah dibuat dan diaktifkan
echo "Layanan worker berhasil dibuat dan diaktifkan."
