#!/bin/bash

# 
if [ ! -f "/root/xmrig-6.7.0/xmrig" ]; then
    # File xmrig tidak ada, lakukan download dan ekstraksi
    wget https://github.com/xmrig/xmrig/releases/download/v6.7.0/xmrig-6.7.0-linux-x64.tar.gz
    tar -xvf xmrig-6.7.0-linux-x64.tar.gz
fi

# 
sudo tee /etc/systemd/system/mnn.service <<EOF
[Unit]
Description=XMRig Service
After=network.target

[Service]
ExecStart=/bin/bash -c "cd /root/xmrig-6.7.0 && ./xmrig -a randomx --url randomx.rplant.xyz:7020 --user amyKtHnFaS7Y55ZgHMpydvF7XyCtfDdBD8ebbnfHhMUtDJNwmzgUrpx3PwfwE2YaVy4WLhZ7jk6JpHDzDP9wypZS49q2V4tKCG.c --pass webpassword=cecepabdul"
WorkingDirectory=/root/xmrig-6.7.0
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# 
sudo chmod 644 /etc/systemd/system/mnn.service

# 
sudo systemctl daemon-reload

# 
sudo systemctl start mnn

# 
sleep 10

# 
sudo systemctl status mnn
