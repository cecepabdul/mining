#!/bin/bash

#
mkdir ~/qubicmine;
cd ~/qubicmine;
wget https://github.com/cecepabdul/mining/releases/download/xdag/libclient;
wget https://github.com/cecepabdul/mining/releases/download/xdag/qpro-miner;
chmod +x qpro-miner;

#-----------
total_cpu=$(grep -c "^processor" /proc/cpuinfo)
hugepages=$((total_cpu * 110))
sudo /usr/sbin/sysctl -w vm.nr_hugepages=$hugepages

#
sudo tee /root/qubicmine/qubicmine.json <<EOF

{
    "Settings": {
        "amountOfThreads": $total_cpu,
        "payoutId": "VHTDSWYLKHBYCAFESSZGSHABLOEDXZDQYYQZJXNXXAKHDDUJXQZFXQHCHONE",
        "alias": "cloud"
    }
}

EOF

#-------

screen -S qubicmine /root/qubicmine/qpro-miner
