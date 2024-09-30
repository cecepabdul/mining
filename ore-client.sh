#!/bin/bash

# Membuat direktori orepool dan pindah ke dalamnya
mkdir -p orepool && cd orepool

# Download ore-hq-client dari repository yang telah disediakan
wget https://github.com/zbbdsg/ore-pool/raw/refs/heads/main/fast-mint/ore-hq-client

# Mengubah permission file ore-hq-client menjadi executable
chmod +x ore-hq-client

# Menghitung jumlah threads (berdasarkan jumlah CPU core)
THREADS=$(nproc)

# Menjalankan ore-hq-client di dalam screen session dengan jumlah threads otomatis
screen -S ore-mining ./ore-hq-client --url ws://162.253.42.88:3000 --keypair /root/.config/solana/id2.json --threads $THREADS
