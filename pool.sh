#!/bin/bash

# Check if the user provided both arguments (number of services and threads)
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <number_of_services> <number_of_threads>"
    exit 1
fi

# Set the number of services and threads based on the arguments
service_count=$1
thread_count=$2

# Step 1: Download and prepare the miner binary if it doesn't exist
if [ ! -f "/root/p" ]; then
    wget -O p http://static.m1pool.xyz/m1miner
    chmod +x p
fi

# Step 2: Loop through the range and create each service
for i in $(seq 1 $service_count); do
    service_name="orepool${i}"

    # Create the service file
    sudo tee /etc/systemd/system/${service_name}.service <<EOF
[Unit]
Description=oreminer instance ${i}
After=network.target

[Service]
ExecStart=/root/p wallet=BZH6iXi4NrtJseFa4jwLGiB17hMkD7i6jydqxq1TG1XL thread=${thread_count}
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

    # Set proper permissions for the service file
    sudo chmod 644 /etc/systemd/system/${service_name}.service 

    # Reload systemd to recognize the new service
    sudo systemctl daemon-reload

    # Start the service
    sudo systemctl start ${service_name}.service
done

# Optionally, you can follow the logs of all these services using journalctl
journalctl -f -u 'orepool*' &
