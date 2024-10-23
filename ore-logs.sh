#!/bin/bash

# Menampilkan log dari Docker yang berisi informasi "Pool Submitted Difficulty", "Pool Earned", "Miner Submitted Difficulty", dan "Miner Earned"
docker logs -f hq-client 2>&1 | grep -E "Pool Submitted Difficulty|Pool Earned|Miner Submitted Difficulty|Miner Earned|Todays Earnings" | while read -r line; do
  echo "$line"
  
  # Jika baris berisi "Miner Earned", tambahkan pemisah untuk setiap set informasi
  if [[ "$line" == *"Miner Earned"* ]]; then
    echo "----------------------"
    echo ""
  fi
done
