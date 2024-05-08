#!/bin/bash

#
cd ~/qubicmine;
wget https://github.com/cecepabdul/mining/releases/download/xdag/libclient;
wget https://github.com/cecepabdul/mining/releases/download/xdag/qpro-miner;
chmod +x qpro-miner;

#-----------
total_cpu=$(grep -c "^processor" /proc/cpuinfo)
hugepages=$((total_cpu * 55))
sudo /usr/sbin/sysctl -w vm.nr_hugepages=$hugepages

#-------

screen -S qubicmine /root/qubicmine/qpro-miner
