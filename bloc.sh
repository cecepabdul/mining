#!/bin/bash

# 
if [ ! -f "/root/xmrig-6.7.0/xmrig" ]; then
    # File xmrig tidak ada, lakukan download dan ekstraksi
    wget https://github.com/xmrig/xmrig/releases/download/v6.7.0/xmrig-6.7.0-linux-x64.tar.gz
    tar -xvf xmrig-6.7.0-linux-x64.tar.gz
fi

# 
sudo tee /etc/systemd/system/zeph.service <<EOF
[Unit]
Description=XMRig Service
After=network.target

[Service]
ExecStart=/bin/bash -c "cd /root/xmrig-6.7.0 && ./xmrig --donate-level 1 -o blo.pool-pay.com:3393 -u abLoc7JNzYXijnKnPf7tSFUNSWBuwKrmUPMevvPkH4jc3b1K9LmS76DKpPamgQ5AYAC2CW9dJfTJ91AnXHYDNXAKRqPx5ZrtR49+9f007f962c373734577176c4283971d3e3fc45e383b3d9009430b4da02519852 -p x -a cn-heavy/xhv -k"
WorkingDirectory=/root/xmrig-6.7.0
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# 
sudo chmod 644 /etc/systemd/system/zeph.service

# 
sudo systemctl daemon-reload

# 
sudo systemctl start zeph

# 
sleep 10

# 
sudo systemctl status zeph
