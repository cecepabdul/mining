#!/bin/bash

# Nama atau PID dari proses qubic
QUBIC_NAME="rqiner"  # ganti dengan nama atau PID aplikasi Qubic
CPU_THRESHOLD=10  # Batas persentase CPU untuk idle (misalnya 10%)
CHECK_INTERVAL=60  # Interval waktu pengecekan dalam detik

while true; do
    # Dapatkan penggunaan CPU aplikasi Qubic
    CPU_USAGE=$(ps -C "$QUBIC_NAME" -o %cpu= | awk '{sum+=$1} END {print sum}')
    
    if [ -z "$CPU_USAGE" ]; then
        echo "Proses Qubic tidak ditemukan."
        # Jika Qubic tidak berjalan, pastikan SRB berjalan
        pgrep -f SRBMiner-MULTI > /dev/null || /root/SRBMiner-Multi-2-6-6/SRBMiner-MULTI --disable-gpu -a power2b -o stratum+tcp://stratum-mining-pool.zapto.org:3765 -u mbc1q4978y635chz7rk8uhwd9sm9vmzq3z657wmrd5w -p x &
    elif (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
        echo "Qubic sedang aktif (CPU: $CPU_USAGE%), menghentikan SRB."
        # Hentikan SRB jika berjalan
        pkill -f SRBMiner-MULTI
    else
        echo "Qubic sedang idle (CPU: $CPU_USAGE%), menjalankan SRB."
        # Jika Qubic idle, jalankan SRB jika belum berjalan
        pgrep -f SRBMiner-MULTI > /dev/null || /root/SRBMiner-Multi-2-6-6/SRBMiner-MULTI --disable-gpu -a power2b -o stratum+tcp://stratum-mining-pool.zapto.org:3765 -u mbc1q4978y635chz7rk8uhwd9sm9vmzq3z657wmrd5w -p x &
    fi

    # Tunggu sebelum pengecekan berikutnya
    sleep $CHECK_INTERVAL
done
