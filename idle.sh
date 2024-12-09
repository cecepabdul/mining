#!/bin/bash

QUBIC_NAME="rqiner"  # Nama proses
CPU_THRESHOLD=10     # Batas penggunaan CPU untuk idle
CHECK_INTERVAL=60    # Interval pengecekan dalam detik
SYSTEMD_NAME="lcn"  # Nama layanan yang disesuaikan

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
    docker logs --tail 100 -f qubic &  # Hanya menampilkan 100 baris terakhir
    MONITOR_PID=$!
}

# Fungsi untuk memantau log berdasarkan nama layanan
monitor_service() {
    echo "Memantau output $SYSTEMD_NAME..."
    journalctl -f -u "$SYSTEMD_NAME" &
    MONITOR_PID=$!
}

while true; do
    QUBIC_PID=$(pgrep -x "$QUBIC_NAME")

    if [ -z "$QUBIC_PID" ]; then
        echo "Proses $QUBIC_NAME tidak ditemukan."
        # Jalankan service jika tidak ada proses rqiner
        if ! systemctl is-active --quiet "$SYSTEMD_NAME"; then
            echo "Menjalankan $SYSTEMD_NAME..."
            systemctl start "$SYSTEMD_NAME"
        fi

        # Ganti pemantauan ke service
        stop_monitoring
        monitor_service
    else
        # Ambil nilai CPU menggunakan `top`
        CPU_USAGE=$(top -b -n 1 -p "$QUBIC_PID" | awk -v pid="$QUBIC_PID" '$1 == pid {print $9}')

        if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
            echo "Qubic sedang aktif (CPU: $CPU_USAGE%), menghentikan $SYSTEMD_NAME."
            systemctl stop "$SYSTEMD_NAME"

            # Ganti pemantauan ke Qubic
            stop_monitoring
            monitor_qubic
        else
            echo "Qubic sedang idle (CPU: $CPU_USAGE%), menjalankan $SYSTEMD_NAME."
            if ! systemctl is-active --quiet "$SYSTEMD_NAME"; then
                echo "Menjalankan $SYSTEMD_NAME..."
                systemctl start "$SYSTEMD_NAME"
            fi

            # Ganti pemantauan ke service
            stop_monitoring
            monitor_service
        fi
    fi

    sleep $CHECK_INTERVAL
done
