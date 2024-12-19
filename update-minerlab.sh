#!/bin/bash


if [ ! -f "/root/dme/sbp" ]; then

   mkdir /root/dme && cd /root/dme
   wget https://github.com/SuperBlockchain-Pool/sbp-miner/releases/download/v1.0.1/sbp-v1.0.1-linux.zip
   unzip sbp-v1.0.1-linux.zip
   chmod +x sbp
fi


total_cpu=$(grep -c "^processor" /proc/cpuinfo)



sudo tee /root/minerlab/appsettings.json 
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
       "arguments": "--donate-level 1 -o stratum+tcp://pool.dme.fairhash.org:3357 -u dmeUyLioqdQ8L2iVGfa9CiPkv86PJjhPQ1gywrnsRSvbWFdptYzTsjWSdmPuyVf9ijC91nHYmA31kesQ1ozZShBj3EdukbSwak -p x -t $total_cpu -v 3"
    }
  }
}

EOF
