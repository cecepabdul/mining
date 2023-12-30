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
ExecStart=/bin/bash -c "cd /root/xmrig-6.7.0 && ./xmrig -k -a rx/0 --donate-level 1 -o us.zephyr.herominers.com:1123 -u ZEPHs6tQo1pCLAWEbVs65DckQpLAigrmTafut3niQZ7EAkrXxvZPnYeDc65pc6PPBxjmqNdh6HtYHeT8mD7eXgTvG8tGhSkmxRH -p b"
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
