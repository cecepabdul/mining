#!/bin/bash

if [ ! -f "/root/SRBMiner-Multi-2-6-6/SRBMiner-MULTI" ]; then
    wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.6.6/SRBMiner-Multi-2-6-6-Linux.tar.gz -P /root
    cd /root
    tar -xvf SRBMiner-Multi-2-6-6-Linux.tar.gz
fi

if [ ! -f "/root/qpro-miner" ]; then
    wget https://dl.qubicmine.pro/qpro-miner
    chmod +x qpro-miner
fi

if [ ! -f "/root/gpool" ]; then
    wget https://github.com/gpool-cloud/gpool-cli/releases/download/v2024.48.1/gpool && chmod +x gpool
fi




# Fungsi untuk menjalankan perintah pertama
run_miner_1() {
    while true; do
        echo "Starting Miner 1..."
        ./qpro-miner --gpu --wallet VHTDSWYLKHBYCAFESSZGSHABLOEDXZDQYYQZJXNXXAKHDDUJXQZFXQHCHONE --worker gpu --url ws.qubicmine.pro --idle "/root/gpool --pubkey BZH6iXi4NrtJseFa4jwLGiB17hMkD7i6jydqxq1TG1XL --no-pcie"
        echo "Miner 1 terminated. Restarting in 5 seconds..."
        sleep 5
    done
}

# Fungsi untuk menjalankan perintah kedua
run_miner_2() {
    while true; do
        echo "Starting Miner 2..."
        ./qpro-miner --cpu --wallet VHTDSWYLKHBYCAFESSZGSHABLOEDXZDQYYQZJXNXXAKHDDUJXQZFXQHCHONE --worker cpu --url ws.qubicmine.pro --idle "/root/SRBMiner-Multi-2-5-9/SRBMiner-MULTI --disable-gpu --algorithm minotaurx --pool stratum+tcp://us.fastpool.xyz:6001 --wallet solo:MLegX9RugBiRMpJjmENLZEtnoPtGrF7o1h --password x"
        echo "Miner 2 terminated. Restarting in 5 seconds..."
        sleep 5
    done
}

# Menjalankan kedua fungsi secara paralel
run_miner_1 &
run_miner_2 &

# Menunggu kedua proses
wait
