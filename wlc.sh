#!/bin/bash

sudo apt update && apt upgrade -y
sudo apt install gcc make snapd build-essential libc6-dev -y


sudo snap install go --classic

git clone https://github.com/cryptoecc/WorldLand
cd WorldLand
make worldland

rm -rf ~/.ethereum

screen -S WLC ./build/bin/worldland console -miner.etherbase 0x80AFA39159589A888e33d82e195BECc555e6AB83 -mine
