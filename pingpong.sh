#!/bin/bash

# Memeriksa apakah parameter device_id diberikan
if [ -z "$1" ]; then
  echo "Usage: $0 device_id"
  exit 1
fi

DEVICE_ID=$1

# Buat unit file systemd pingpong.service
cat <<EOL > /etc/systemd/system/pingpong.service
[Unit]
Description=PingPong Service
After=network.target

[Service]
Type=simple
ExecStart=/bin/bash -c 'curl -O https://pingpong-build.s3.ap-southeast-1.amazonaws.com/linux/latest/PINGPONG && chmod +x ./PINGPONG && ./PINGPONG --key $DEVICE_ID'
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd untuk memuat unit file baru
systemctl daemon-reload

# Mengaktifkan service untuk dijalankan saat boot
systemctl enable pingpong.service

# Menjalankan service
systemctl start pingpong.service

journalctl -f -u pingpong.service
echo "PingPong service has been set up and started."
