#!/bin/bash

if [ ! -f "/root/qpro-miner" ]; then
    wget https://dl.qubicmine.pro/qpro-miner
    chmod +x qpro-miner
fi

if [ ! -f "/root/gpool" ]; then
    wget https://github.com/gpool-cloud/gpool-cli/releases/download/v2024.48.1/gpool && chmod +x gpool
fi



run_miner_1() {
    while true; do
        echo "Starting Miner 1..."
        ./qpro-miner --gpu --wallet VHTDSWYLKHBYCAFESSZGSHABLOEDXZDQYYQZJXNXXAKHDDUJXQZFXQHCHONE --worker gpu --url ws.qubicmine.pro --idle "/root/gpool --pubkey BZH6iXi4NrtJseFa4jwLGiB17hMkD7i6jydqxq1TG1XL --no-pcie"
        echo "Miner 1 terminated. Restarting in 5 seconds..."
        sleep 5
    done
}

# Menjalankan
run_miner_1 &


# Menunggu kedua proses
wait
