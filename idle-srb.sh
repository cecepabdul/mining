#!/bin/bash

wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.6.6/SRBMiner-Multi-2-6-6-Linux.tar.gz
tar -xvf SRBMiner-Multi-2-6-6-Linux.tar.gz

# Mendapatkan jumlah total CPU di sistem
total_cpu=$(nproc)

chmod +x ./SRBMiner-Multi-2-6-6/SRBMiner-MULTI

# Jalankan SRBMiner-MULTI dengan parameter yang Anda inginkan
./SRBMiner-Multi-2-6-6/SRBMiner-MULTI -a power2b -o stratum+tcp://stratum-mining-pool.zapto.org:3765 -u MpTmkKueJSaKe9TJDbefvJooSLENUSkgpQ.b -p x -t $total_cpu
