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

# Install Solana
sh -c "$(curl -sSfL https://release.solana.com/v1.18.22/install)"

# Set path Solana dan tambahkan ke .bashrc
export PATH="/root/.local/share/solana/install/active_release/bin:$PATH"
echo 'export PATH="/root/.local/share/solana/install/active_release/bin:$PATH"' >> $HOME/.bashrc
source $HOME/.bashrc

# Generate Solana keypair
solana-keygen new --no-bip39-passphrase --outfile $HOME/.config/solana/id.json

# Konfigurasi Solana
solana config set --url https://api.mainnet-beta.solana.com

# Install ore-cli dan coal-cli
cargo install ore-hq-client

# Tambahkan path cargo ke PATH
export PATH=$PATH:$HOME/.cargo/bin
echo 'export PATH=$PATH:$HOME/.cargo/bin' >> $HOME/.bashrc

echo "Instalasi selesai."
