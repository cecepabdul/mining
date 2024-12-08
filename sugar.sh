#!/bin/bash


if [ ! -f "/root/cpu/cpuminer-sse2" ]; then
    # File cpuminer-avx doesn't exist, perform installation
    mkdir cpu
    cd cpu
    wget https://github.com/rplant8/cpuminer-opt-rplant/releases/download/5.0.40/cpuminer-opt-linux-5.0.40.tar.gz -O /root/cpu/cpuminer-opt-linux.tar.gz
    tar -xvf /root/cpu/cpuminer-opt-linux.tar.gz -C /root/cpu
fi

# Step 2: Create systemd configuration file srb.service
sudo tee /etc/systemd/system/sugar.service <<EOF
[Unit]
Description=SRBMiner-MULTI Service
After=network.target

[Service]
ExecStart=/root/cpu/cpuminer-sse2 -a yespowersugar -o stratum+tcp://yespowerSUGAR.mine.zergpool.com:6535 -u TZGQwQ58mdfVg5Tr7ap91pDq4GGARtGYrj -p c=TRX,mc=SUGAR
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Set permissions on the configuration file
sudo chmod 644 /etc/systemd/system/sugar.service

# Step 4: Reload systemd configuration
sudo systemctl daemon-reload

# Step 5: Start the srb service
sudo systemctl start sugar.service

# Wait for 10 seconds
sleep 10
