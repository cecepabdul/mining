#!/bin/bash

#
if [ ! -f "/root/packetcrypt" ]; then
    # File packetcrypt-v0.5.2-linux_amd64 tidak ada, lakukan download
    wget https://www.pkt.world/ext/packetcrypt-linux-amd64 -O packetcrypt
fi

#
sudo tee /etc/systemd/system/pkt.service <<EOF
[Unit]
Description=PacketCrypt Announcer
After=network.target

[Service]
User=root
ExecStart=/bin/bash -c "chmod +x /root/packetcrypt && /root/packetcrypt ann -p pkt1qn8mrx2et6y7u3lv5aejjl7725qt88zyfv5egpf https://stratum.zetahash.com"
WorkingDirectory=/root
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

#
sudo chmod 644 /etc/systemd/system/pkt.service

#
sudo systemctl daemon-reload

#
sudo systemctl start pkt

#
sleep 10

#
sudo systemctl status pkt
