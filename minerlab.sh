#!/bin/bash



if [ ! -f "/root/minerlab/qli-Client" ]; then
  mkdir minerlab
  cd minerlab
  wget https://dl.qubic.li/downloads/qli-Client-3.1.1-Linux-x64.tar.gz && tar -xvf qli-Client-3.1.1-Linux-x64.tar.gz && rm qli-Client-3.1.1-Linux-x64.tar.gz && rm appsettings.json
fi

# Menghitung jumlah CPU yang tersedia
CPU_THREADS=$(nproc)


sudo tee /root/minerlab/appsettings.json <<EOF
{
  "ClientSettings": {
    "poolAddress": "wss://pps.minerlab.io/ws/CECEPABDUL",
    "alias": "cloud",
    "trainer": {
      "cpu": true,
      "gpu": false,
      "cpuThreads": -1
    },
    "accessToken": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6ImQzNzMyODc2LTY5ZDctNGI1OC1hNmUzLWM2MzZkMGQ4ZDE0NiIsIk1pbmluZyI6IiIsIm5iZiI6MTcyNTM3NjkyOSwiZXhwIjoxNzU2OTEyOTI5LCJpYXQiOjE3MjUzNzY5MjksImlzcyI6Imh0dHBzOi8vcXViaWMubGkvIiwiYXVkIjoiaHR0cHM6Ly9xdWJpYy5saS8ifQ.sregOyk2PEyXv8ssdQDBtTps1JFBLghcJCzDFvaD6hWoVA_T-crfQZbiV0E_atqd6sxNHYKGmeVCOoU9crLU4mnojZdF1vyp3VttB3ZIqo3qIgr0R4jWnwZ95bGN1c6NE3zb9y7ZWor5-4ttLkR_5moxiZZvaKG2WWSxFJ-7kk6SVSw7z8iaYyVpPX1Tdu6pBWxDStYYaoVvgNzx6RShU_r2AVCB1JGfv16vKvAIGmPcluvS-ayKwfgOpY1uEbsH6Lswd_KGbB1aJC7g8AI1CUoYiUUl_CJUBZfG0FbBgtGDRhfPUcYM5z8BEyIrm6bfKhMHuJmIF86NJYydRUHgow",
    "qubicAddress": null,
    "displayDetailedHashrates": true,
    "pps": true,
    "idling": {
       "command": "/root/dme/sbp",
       "arguments": "--donate-level 1 -o stratum+tcp://pool.dme.fairhash.org:3357 -u dmeUyLioqdQ8L2iVGfa9CiPkv86PJjhPQ1gywrnsRSvbWFdptYzTsjWSdmPuyVf9ijC91nHYmA31kesQ1ozZShBj3EdukbSwak -p x -t $CPU_THREADS -v 3"
    }
  }
}
EOF

sudo tee /etc/systemd/system/minerlab.service <<EOF
[Unit]
Description=qubic
After=network.target

[Service]
ExecStart=/root/minerlab/qli-Client
WorkingDirectory=/root/minerlab/
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF


sudo systemctl daemon-reload
sudo systemctl start minerlab.service

journalctl -f -u minerlab.service
