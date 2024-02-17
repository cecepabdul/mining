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
ExecStart=/bin/bash -c "cd /root/xmrig-6.7.0 && ./xmrig -k -a rx/0 --donate-level 1 -o us.zephyr.herominers.com:1123 -u ZEPHYR3R9jmPei2LqVFDKXMSxpo9kLMtYD1fmvtag4jcWDkwH1qqQViaYW56yh6ZNwiVovShVV36LhvSWCmj2jyzR3dc4ZAUQjG4L -p cloud"
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
