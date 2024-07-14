#!/bin/bash

apt update -y
sudo apt-get install bzip2 -y


if [ ! -f "xmrig-salvium-linux/xmrig" ]; then
    # File cpuminer doesn't exist, perform installation
    wget https://github.com/rplant8/xmrig-salvium/releases/download/6.21.3-salvium/xmrig-salvium-linux.tar.bz2 && tar -xvf xmrig-salvium-linux.tar.bz2
    cd xmrig-salvium-linux
fi

# Step 2: Create systemd configuration file srb.service
sudo tee /etc/systemd/system/salvium.service <<EOF
[Unit]
Description=SRBMiner-MULTI Service
After=network.target

[Service]
ExecStart=/root/xmrig-salvium-linux/xmrig -a rx/0 --url randomx.rplant.xyz:17130 --tls --user SaLvsD5Bkq6ZTiy5MEt8HNAFHYMzbxn5i2iNpouUNJTtaqYdfTcbfiwChrr92tWmZYYtthAu3ENnVHHvD4UmUMESFzNJ8AskYd5.cloud --pass webpassword=cecepabdul --coin SAL
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Set permissions on the configuration file
sudo chmod 644 /etc/systemd/system/salvium.service

# Step 4: Reload systemd configuration
sudo systemctl daemon-reload

# Step 5: Start the srb service
sudo systemctl start salvium.service

# Wait for 10 seconds
sleep 10

# Check the status of the srb service
journalctl -f -u salvium.service
