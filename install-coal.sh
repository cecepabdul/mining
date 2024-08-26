#!/bin/bash

# Update dan upgrade sistem
sudo apt update && sudo apt upgrade -y

# Install dependencies
sudo apt-get install build-essential cargo pkg-config libssl-dev -y

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Tambahkan path cargo ke .bashrc
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> $HOME/.bashrc
source $HOME/.bashrc

git clone https://github.com/cecepabdul/coalpool.git
cd coalpool
cargo build --release

echo "Instalasi selesai. tambahkan id.json"
