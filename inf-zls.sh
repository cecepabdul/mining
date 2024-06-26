#!/bin/bash

# 
if [ ! -f "/root/xmrig-6.7.0/xmrig" ]; then
    # File xmrig tidak ada, lakukan download dan ekstraksi
    wget https://github.com/xmrig/xmrig/releases/download/v6.7.0/xmrig-6.7.0-linux-x64.tar.gz
    tar -xvf xmrig-6.7.0-linux-x64.tar.gz
fi

# 
sudo tee /etc/systemd/system/inf-zls.service <<EOF
[Unit]
Description=XMRig Service
After=network.target

[Service]
ExecStart=/bin/bash -c "cd /root/xmrig-6.7.0 && ./xmrig --donate-level 1 -a cn/zls -o superblockchain.con-ip.com:11124 -u solo:infi89MBWGDLVvDxrVy3AQbVtmg4cYwXAYktgnSJhTYi3xGDQFViwhb3ctfJeRgnCsf7MDzbYPi7VdDiYmg3Y17LSy9cpSb7zch -p @b"
WorkingDirectory=/root/xmrig-6.7.0
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# 
sudo chmod 644 /etc/systemd/system/inf-zls.service

# 
sudo systemctl daemon-reload

# 
sudo systemctl start inf-zls

# 
sleep 10

# 
sudo systemctl status inf-zls
