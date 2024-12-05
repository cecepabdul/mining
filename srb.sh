#!/bin/bash

QUBIC_NAME="rqiner"  # Nama proses
CPU_THRESHOLD=10     # Batas penggunaan CPU untuk idle
CHECK_INTERVAL=60    # Interval pengecekan dalam detik

while true; do
    QUBIC_PID=$(pgrep -x "$QUBIC_NAME")
    
    if [ -z "$QUBIC_PID" ]; then
        echo "Proses $QUBIC_NAME tidak ditemukan."
        # Jalankan SRBMiner jika tidak ada proses rqiner
        if ! pgrep -f SRBMiner-MULTI > /dev/null; then
            echo "Menjalankan SRBMiner..."
            /root/SRBMiner-Multi-2-6-6/SRBMiner-MULTI --disable-gpu -a yespowersugar -o stratum+tcp://yespowerSUGAR.mine.zergpool.com:6535 -u TZGQwQ58mdfVg5Tr7ap91pDq4GGARtGYrj -p c=TRX,mc=SUGAR &
        fi
    else
        # Ambil nilai CPU menggunakan `top`
        CPU_USAGE=$(top -b -n 1 -p "$QUBIC_PID" | awk -v pid="$QUBIC_PID" '$1 == pid {print $9}')
        
        if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
            echo "Qubic sedang aktif (CPU: $CPU_USAGE%), menghentikan SRB."
            pkill -f SRBMiner-MULTI
        else
            echo "Qubic sedang idle (CPU: $CPU_USAGE%), menjalankan SRB."
            if ! pgrep -f SRBMiner-MULTI > /dev/null; then
                echo "Menjalankan SRBMiner..."
                /root/SRBMiner-Multi-2-6-6/SRBMiner-MULTI --disable-gpu -a yespowersugar -o stratum+tcp://yespowerSUGAR.mine.zergpool.com:6535 -u TZGQwQ58mdfVg5Tr7ap91pDq4GGARtGYrj -p c=TRX,mc=SUGAR &
            fi
        fi
    fi
    
    sleep $CHECK_INTERVAL
done
