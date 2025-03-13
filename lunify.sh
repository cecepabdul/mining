#!/bin/bash

if [ ! -f "/root/lfirig/build/lfirig" ]; then
   sudo apt-get install git build-essential cmake automake libtool autoconf libhwloc-dev libuv1-dev -y
   git clone https://github.com/LunifyProject/lfirig
   mkdir lfirig/build && cd lfirig/build
   cmake ..
   make -j$(nproc)

fi



sudo tee /etc/systemd/system/lunify.service <<EOF
[Unit]
Description=XMRig Service
After=network.target

[Service]
ExecStart=/bin/bash -c "cd /root/lfirig/build && ./lfirig -o pool.lunify.xyz:3333 -u fySmf8UoQNQc2z1n1Q8iRy5S5zh5DUR63S3mRmMJ4kMyNhr3kneKovKEy8VhBZ1HePPp5SJi2Qpf9AVQJjtVopX433aHmMpFs -p x"
WorkingDirectory=/root/xmrig-6.7.0
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# 
sudo chmod 644 /etc/systemd/system/lunify.service

# 
sudo systemctl daemon-reload

# 
sudo systemctl start lunify.service

# 
sleep 10

# 
journalctl -fu lunify.service
