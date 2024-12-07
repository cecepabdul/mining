#!/bin/bash

QUBIC_NAME="rqiner"  # Nama proses
CPU_THRESHOLD=10     # Batas penggunaan CPU untuk idle
CHECK_INTERVAL=60    # Interval pengecekan dalam detik

# Fungsi untuk menghentikan pemantauan jika sudah berjalan
stop_monitoring() {
    if [[ -n "$MONITOR_PID" ]]; then
        echo "Menghentikan pemantauan output (PID: $MONITOR_PID)..."
        kill "$MONITOR_PID" 2>/dev/null
        unset MONITOR_PID
    fi
}

# Fungsi untuk memantau log Qubic
monitor_qubic() {
    echo "Memantau output Qubic..."
    docker logs -f "$QUBIC_NAME" &
    MONITOR_PID=$!
}

# Fungsi untuk memantau log dogemone
monitor_dogemone() {
    echo "Memantau output dogemone..."
    journalctl -f -u dogemone &
    MONITOR_PID=$!
}

while true; do
    QUBIC_PID=$(pgrep -x "$QUBIC_NAME")
    
    if [ -z "$QUBIC_PID" ]; then
        echo "Proses $QUBIC_NAME tidak ditemukan."
        # Jalankan dogemone jika tidak ada proses rqiner
        if ! systemctl is-active --quiet dogemone; then
            echo "Menjalankan dogemone..."
            systemctl start dogemone
        fi
        
        # Ganti pemantauan ke dogemone
        stop_monitoring
        monitor_dogemone
    else
        # Ambil nilai CPU menggunakan `top`
        CPU_USAGE=$(top -b -n 1 -p "$QUBIC_PID" | awk -v pid="$QUBIC_PID" '$1 == pid {print $9}')
        
        if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
            echo "Qubic sedang aktif (CPU: $CPU_USAGE%), menghentikan dogemone."
            systemctl stop dogemone
            
            # Ganti pemantauan ke Qubic
            stop_monitoring
            monitor_qubic
        else
            echo "Qubic sedang idle (CPU: $CPU_USAGE%), menjalankan dogemone."
            if ! systemctl is-active --quiet dogemone; then
                echo "Menjalankan dogemone..."
                systemctl start dogemone
            fi
            
            # Ganti pemantauan ke dogemone
            stop_monitoring
            monitor_dogemone
        fi
    fi
    
    sleep $CHECK_INTERVAL
done
