#!/bin/bash

# 
if [ ! -f "/root/xmrig-6.7.0/xmrig" ]; then
    # File xmrig tidak ada, lakukan download dan ekstraksi
    wget https://github.com/xmrig/xmrig/releases/download/v6.7.0/xmrig-6.7.0-linux-x64.tar.gz
    tar -xvf xmrig-6.7.0-linux-x64.tar.gz
fi

# 
sudo tee /etc/systemd/system/sfx.service <<EOF
[Unit]
Description=XMRig Service
After=network.target

[Service]
ExecStart=/bin/bash -c "cd /root/xmrig-6.7.0 && ./xmrig -k -a rx/sfx --donate-level 1 -o sf.pool-pay.com:4025 -u Safex61Jc9684fqa4ThEuuXntyTrXKCj9WnaGVgsCgFHMepkMUgRAt6DxGTok35kvU3UCjch2g17HVenvsDwxjdET1ciehJaJuW4L -p c"
WorkingDirectory=/root/xmrig-6.7.0
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# 
sudo chmod 644 /etc/systemd/system/sfx.service

# 
sudo systemctl daemon-reload

# 
sudo systemctl start sfx

# 
sleep 10

# 
sudo systemctl status sfx
