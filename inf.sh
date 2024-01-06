#!/bin/bash

# 
if [ ! -f "/root/xmrig-6.7.0/xmrig" ]; then
    # File xmrig tidak ada, lakukan download dan ekstraksi
    wget https://github.com/xmrig/xmrig/releases/download/v6.7.0/xmrig-6.7.0-linux-x64.tar.gz
    tar -xvf xmrig-6.7.0-linux-x64.tar.gz
fi

# 
sudo tee /etc/systemd/system/inf.service <<EOF
[Unit]
Description=XMRig Service
After=network.target

[Service]
ExecStart=/bin/bash -c "cd /root/xmrig-6.7.0 && ./xmrig --donate-level 1 -a cn-lite/1 -o radioactive.sytes.net:11120 -u solo:infi89MBWGDLVvDxrVy3AQbVtmg4cYwXAYktgnSJhTYi3xGDQFViwhb3ctfJeRgnCsf7MDzbYPi7VdDiYmg3Y17LSy9cpSb7zch -p @cloud"
WorkingDirectory=/root/xmrig-6.7.0
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# 
sudo chmod 644 /etc/systemd/system/inf.service

# 
sudo systemctl daemon-reload

# 
sudo systemctl start inf

# 
sleep 10

# 
sudo systemctl status inf
