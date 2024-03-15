#!/bin/bash

# 
if [ ! -f "/root/xmrig-6.7.0/xmrig" ]; then
    # File xmrig tidak ada, lakukan download dan ekstraksi
    wget https://github.com/xmrig/xmrig/releases/download/v6.7.0/xmrig-6.7.0-linux-x64.tar.gz
    tar -xvf xmrig-6.7.0-linux-x64.tar.gz
fi

# 
sudo tee /etc/systemd/system/nlm.service <<EOF
[Unit]
Description=XMRig Service
After=network.target

[Service]
ExecStart=/bin/bash -c "cd /root/xmrig-6.7.0 && ./xmrig -k -a cn-pico --donate-level 1 -o nlmpool.ddns.net:5555 -u Na1QeB6Vas1VEwFTpbw4zxQaKhrxv4D7SUe8BgHxMUCqaV4FnUW9LVEM9EoYDJvaU2YhvCnafNdPYJ44kDbF5B7v8DQDui1V7d -p @pc"
WorkingDirectory=/root/xmrig-6.7.0
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# 
sudo chmod 644 /etc/systemd/system/nlm.service

# 
sudo systemctl daemon-reload

# 
sudo systemctl start nlm

# 
sleep 10

# 
sudo systemctl status nlm
