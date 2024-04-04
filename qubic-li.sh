#!/bin/bash

#
rm -rf qubic

mkdir ~/qubic;
cd ~/qubic;
wget https://dl.qubic.li/downloads/qli-Client-1.9.0-Linux-x64.tar.gz;
tar -xvf qli-Client-1.9.0-Linux-x64.tar.gz;
rm qli-Client-1.9.0-Linux-x64.tar.gz;

#-----------
total_cpu=$(grep -c "^processor" /proc/cpuinfo)
hugepages=$((total_cpu * 52))
sudo /usr/sbin/sysctl -w vm.nr_hugepages=$hugepages

#
sudo tee /root/qubic/appsettings.json <<EOF
{
  "Settings": {
    "baseUrl": "https://mine.qubic.li/",
    "overwrites": {},
    "accessToken": "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJJZCI6ImFjZGRlNzEzLWE3MTMtNGQwYy05MTY0LTFlOTQ0M2I1NDU0MyIsIk1pbmluZyI6IiIsIm5iZiI6MTcxMjI1MzA1NywiZXhwIjoxNzQzNzg5MDU3LCJpYXQiOjE3MTIyNTMwNTcsImlzcyI6Imh0dHBzOi8vcXViaWMubGkvIiwiYXVkIjoiaHR0cHM6Ly9xdWJpYy5saS8ifQ.6e4N_9wnKrEgtDxbGpkBioqNqj-qdwZHs16IQPcyv-t58rJaDkFuzvQFFnoHxGEYyfIah88waSHNBCwjXDNveQ",
    "amountOfThreads": $total_cpu,
    "alias": "cloud"
  }
}
EOF

#-------

screen -S qubic ./qli-Client
