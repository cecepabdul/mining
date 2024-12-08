#!/bin/bash

QUBIC_NAME="rqiner"  # Nama proses
CPU_THRESHOLD=10     # Batas penggunaan CPU untuk idle
CHECK_INTERVAL=60    # Interval pengecekan dalam detik
SYSTEMD_NAME="sugar"  # Nama layanan dogemone yang sudah diubah

# Fungsi untuk memulai dogemone
start_dogemone() {
    if ! systemctl is-active --quiet "$SYSTEMD_NAME"; then
        echo "Menjalankan $SYSTEMD_NAME..."
        systemctl start "$SYSTEMD_NAME"
    fi
}

# Fungsi untuk menghentikan dogemone
stop_dogemone() {
    if systemctl is-active --quiet "$SYSTEMD_NAME"; then
        echo "Menghentikan $SYSTEMD_NAME..."
        systemctl stop "$SYSTEMD_NAME"
    fi
}

while true; do
    QUBIC_PID=$(pgrep -x "$QUBIC_NAME")
    
    if [ -z "$QUBIC_PID" ]; then
        echo "Proses $QUBIC_NAME tidak ditemukan."
        # Jalankan dogemone jika tidak ada proses rqiner
        start_dogemone
        echo "Menampilkan log dogemone (jika aktif)..."
        journalctl -f -u "$SYSTEMD_NAME"  # Menampilkan log dogemone jika aktif
    else
        # Ambil nilai CPU menggunakan `top`
        CPU_USAGE=$(top -b -n 1 -p "$QUBIC_PID" | awk -v pid="$QUBIC_PID" '$1 == pid {print $9}')
        
        if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
            echo "$QUBIC_NAME sedang aktif (CPU: $CPU_USAGE%), menghentikan $SYSTEMD_NAME."
            stop_dogemone
            echo "Menampilkan log Qubic (jika aktif)..."
            docker logs -f qubic  # Menampilkan log Qubic jika aktif
        else
            echo "$QUBIC_NAME sedang idle (CPU: $CPU_USAGE%), menjalankan $SYSTEMD_NAME."
            start_dogemone
            echo "Menampilkan log dogemone (jika aktif)..."
            journalctl -f -u "$SYSTEMD_NAME"  # Menampilkan log dogemone jika aktif
        fi
    fi
    
    sleep $CHECK_INTERVAL
done
