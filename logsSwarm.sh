#!/bin/bash

# Fungsi untuk mendapatkan ID kontainer dari nama
get_container_id() {
    docker ps -q --filter "name=$1"
}

# Fungsi untuk menampilkan log kontainer secara real-time
show_logs() {
    local container_name=$1
    local container_id=$(get_container_id "$container_name")

    if [ -n "$container_id" ]; then
        echo "Menampilkan log dari $container_name ($container_id)..."
        docker logs -f "$container_id"
    else
        echo "Kontainer $container_name tidak ditemukan atau tidak berjalan."
    fi
}

# Monitoring log utama dari qubic
main_container="qubic"
secondary_container="second-coin"
echo "Memulai log dari $main_container sebagai utama..."

while :; do
    # Periksa apakah kontainer secondary_container sedang berjalan
    secondary_id=$(get_container_id "$secondary_container")

    if [ -n "$secondary_id" ]; then
        echo "$secondary_container berjalan. Mengalihkan log..."

        # Hentikan log dari main_container
        pkill -f "docker logs -f $(get_container_id $main_container)"

        # Tampilkan log dari secondary_container
        show_logs "$secondary_container"
        exit 0
    else
        # Tampilkan log dari main_container jika secondary_container belum berjalan
        show_logs "$main_container"
    fi

    # Tunggu beberapa detik sebelum mengecek kembali
    sleep 5
done
