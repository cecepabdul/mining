#!/bin/bash

rm -rf qubic
mkdir qubic
cd qubic
wget https://github.com/cecepabdul/mining/releases/download/xdag/qli-Client && chmod +x qli-Client


# Mendapatkan jumlah CPU yang tersedia
total_cpu=$(nproc)


sudo tee /root/qubic/appsettings.json <<EOF
{
  "Settings": {
    "baseUrl": "https://mine.qubic.li/",
    "amountOfThreads": $total_cpu,
    "payoutId": "",
    "accessToken": "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJJZCI6ImFjZGRlNzEzLWE3MTMtNGQwYy05MTY0LTFlOTQ0M2I1NDU0MyIsIk1pbmluZyI6IiIsIm5iZiI6MTcxMTU2MzQxOSwiZXhwIjoxNzQzMDk5NDE5LCJpYXQiOjE3MTE1NjM0MTksImlzcyI6Imh0dHBzOi8vcXViaWMubGkvIiwiYXVkIjoiaHR0cHM6Ly9xdWJpYy5saS8ifQ.VB3Vt7KbqhBmkA-0A3wEAdRRKS4fgI9Fczggag4Qhwf9WF5Jx5MRfrLu3VBNQH--hrzyln88TUaxgfyPzwnlOg",
    "alias": "cloud"
  }
}
EOF

sudo /usr/sbin/sysctl -w vm.nr_hugepages=1612

sudo tee /etc/systemd/system/qubic-portal.service <<EOF
[Unit]
Description=qubic portal
After=network.target

[Service]
ExecStart=/root/qubic/qli-Client
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF


systemctl daemon-reload
systemctl start qubic-portal
sleep 5

journalctl -f -u qubic-portal

