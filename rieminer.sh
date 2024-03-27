#!/bin/bash

#
apt install g++ make m4 git libgmp-dev libssl-dev libcurl4-openssl-dev nlohmann-json3-dev -y
git clone https://github.com/Pttn/rieMiner.git
cd rieMiner
sh GetDependencies.sh
cd rieMiner0.93aDeps
cd ..
make

#
sudo tee /root/rieMiner/rieMiner.conf <<EOF
Mode = Pool
Host = Stelo.xyz
Port = 2005
Username = ric1puv334afc59q9h5uhsyf0tvqhdx9agucwjgj0fn0vgrq5mq8we8nqhkc5zz
EOF

#
sudo tee /etc/systemd/system/rieminer.service <<EOF
[Unit]
Description=rieminer Service
After=network.target

[Service]
ExecStart=/root/rieMiner/rieMiner
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

#
systemctl daemon-reload
systemctl start rieminer
sleep 5

journalctl -f -u rieminer
