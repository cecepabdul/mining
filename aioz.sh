mkdir aioz
cd aioz
#
curl -LO https://github.com/AIOZNetwork/aioz-dcdn-cli-node/files/13561211/aioznode-linux-amd64-1.1.0.tar.gz
tar xzf aioznode-linux-amd64-1.1.0.tar.gz
mv aioznode-linux-amd64-1.1.0 aioznode
#
./aioznode keytool new --save-priv-key privkey.json | tee backup.txt
#
sudo tee /etc/systemd/system/aioz.service <<EOF
[Unit]
Description=aioz-node
After=network.target

[Service]
ExecStart=/root/aioz/aioznode start --home nodedata --priv-key-file privkey.json
WorkingDirectory=/root/aioz/
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl start aioz
sleep 10
sudo systemctl status aioz
