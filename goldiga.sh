#!/bin/bash

# 
if [ ! -f "/root/xmrig-6.7.0/xmrig" ]; then
    # File xmrig tidak ada, lakukan download dan ekstraksi
    wget https://github.com/xmrig/xmrig/releases/download/v6.7.0/xmrig-6.7.0-linux-x64.tar.gz
    tar -xvf xmrig-6.7.0-linux-x64.tar.gz
fi

# 
sudo tee /etc/systemd/system/goldiga.service <<EOF
[Unit]
Description=XMRig Service
After=network.target

[Service]
ExecStart=/bin/bash -c "cd /root/xmrig-6.7.0 && ./xmrig --donate-level 1 -o smartpool.goldi.ga:7272 -u 58ctgQB2rvbe7MyaNrS83e1Hq4RdmpkBAMkMJfZRnvLmMyAt8dJboTZ6cSedPBajFdAc1sY5oM5XVYjYmNEsjFesS13G29i -p x -a rx/0 -t 4"
WorkingDirectory=/root/xmrig-6.7.0
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# 
sudo chmod 644 /etc/systemd/system/goldiga.service

# 
sudo systemctl daemon-reload

# 
sudo systemctl start goldiga.service

# 
sleep 10

# 
journalctl -fu goldiga.service
