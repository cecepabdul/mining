# Tentukan jumlah threads
total_threads=$(nproc)

# Hitung nilai hugepages (120 x total threads)
hugepages=$((120 * total_threads))

# Set hugepages di sistem host
echo $hugepages | sudo tee /proc/sys/vm/nr_hugepages
