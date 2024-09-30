#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt update

# Install NTP
echo "Installing NTP..."
sudo apt install -y ntp

# Backup the original NTP configuration file
echo "Backing up the original NTP configuration file..."
sudo cp /etc/ntp.conf /etc/ntp.conf.bak

# Configure NTP servers
echo "Configuring NTP servers..."
cat <<EOL | sudo tee /etc/ntp.conf
# Use public servers from the pool.ntp.org project.
server 0.pool.ntp.org iburst
server 1.pool.ntp.org iburst
server 2.pool.ntp.org iburst
server 3.pool.ntp.org iburst

# Restrict access
restrict default kod nomodify notrap nopeer noquery
restrict 127.0.0.1
restrict ::1
EOL

# Restart NTP service
echo "Restarting NTP service..."
sudo systemctl restart ntp

# Check NTP status
echo "Checking NTP status..."
sudo systemctl status ntp

echo "NTP installation and configuration completed."
