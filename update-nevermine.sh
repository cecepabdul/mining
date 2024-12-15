sudo systemctl stop nevermine.service

sudo tee /etc/systemd/system/nevermine.service <<EOF
[Unit]
Description=qubic
After=network.target

[Service]
ExecStart=/root/qubic/qpro-miner --cpu --wallet VHTDSWYLKHBYCAFESSZGSHABLOEDXZDQYYQZJXNXXAKHDDUJXQZFXQHCHONE --worker cloud --url ws.qubicmine.pro --idle "/root/SRBMiner-Multi-2-6-6/SRBMiner-MULTI --disable-gpu --algorithm yespowertide --pool stratum+tcps://stratum-na.rplant.xyz:17059 --wallet TYj2cUrnoX7snkiTnpWHRKYCRZNAczZXFR.cloud --password x"
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF


sudo systemctl daemon-reload
sudo systemctl start nevermine.service

journalctl -f -u nevermine.service
