#!/bin/bash

#
wget wget -O qli-Service-install.sh https://dl.qubic.li/cloud-init/qli-Service-install.sh

total_cpu=$(nproc)

#
bash qli-Service-install.sh $total_cpu eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJJZCI6ImFjZGRlNzEzLWE3MTMtNGQwYy05MTY0LTFlOTQ0M2I1NDU0MyIsIk1pbmluZyI6IiIsIm5iZiI6MTcxMTU2MzQxOSwiZXhwIjoxNzQzMDk5NDE5LCJpYXQiOjE3MTE1NjM0MTksImlzcyI6Imh0dHBzOi8vcXViaWMubGkvIiwiYXVkIjoiaHR0cHM6Ly9xdWJpYy5saS8ifQ.VB3Vt7KbqhBmkA-0A3wEAdRRKS4fgI9Fczggag4Qhwf9WF5Jx5MRfrLu3VBNQH--hrzyln88TUaxgfyPzwnlOg

#
tail -f /var/log/qli.log
