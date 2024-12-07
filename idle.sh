#!/bin/bash

QUBIC_NAME="rqiner"  # Nama proses
CPU_THRESHOLD=10     # Batas penggunaan CPU untuk idle
CHECK_INTERVAL=60    # Interval pengecekan dalam detik

while true; do
    QUBIC_PID=$(pgrep -x "$QUBIC_NAME")
    
    if [ -z "$QUBIC_PID" ]; then
        echo "Proses $QUBIC_NAME tidak ditemukan."
        # Jalankan dogemone jika tidak ada proses rqiner
        if ! systemctl is-active --quiet dogemone; then
            echo "Menjalankan dogemone..."
            systemctl start dogemone
        fi
    else
        # Ambil nilai CPU menggunakan `top`
        CPU_USAGE=$(top -b -n 1 -p "$QUBIC_PID" | awk -v pid="$QUBIC_PID" '$1 == pid {print $9}')
        
        if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
            echo "Qubic sedang aktif (CPU: $CPU_USAGE%), menghentikan dogemone."
            systemctl stop dogemone
        else
            echo "Qubic sedang idle (CPU: $CPU_USAGE%), menjalankan dogemone."
            if ! systemctl is-active --quiet dogemone; then
                echo "Menjalankan dogemone..."
                systemctl start dogemone
            fi
        fi
    fi
    
    sleep $CHECK_INTERVAL
done
