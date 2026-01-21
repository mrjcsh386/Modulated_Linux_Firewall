#! /bin/bash

# /usr/local/sbin/apt-remove-ips.sh
# Author: mrjcsh386@gmail.com + ChatGPT
# 12 January, 2026
# Tested with: nft v1.0.6 (Lester Gooch #5)

# Purpose: To be called by apts PostInvoke hook sealing firewall to original
#   safer defaults.

# Notes: This script will:
#   - Extract IPs from TRACKING_FILE
#   - Remove IPs from NFT_SET


NFT_SET="repo_ips"
TRACKING_FILE="/var/run/apt_ips.list"

if [[ ! -f "$TRACKING_FILE" ]]; then

  exit 0

fi

while read -r ip; do

  [[ -n "$ip" ]] && nft delete element inet filter $NFT_SET { $ip }

done < "$TRACKING_FILE"
