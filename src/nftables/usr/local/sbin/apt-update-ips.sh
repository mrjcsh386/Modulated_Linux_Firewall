#! /bin/bash

# /usr/local/sbin/apt-update-ips.sh
# Author: mrjcsh386@gmail.com + ChatGPT
# 12 January, 2026
# Tested with: nft v1.0.6 (Lester Gooch #5)

# Purpose: To be called by apts PreInvoke hook permitting updates.

# Notes: This script will:
#   - Extract domains from all sources.list files.
#   - Resolve them to IPs
#   - Write the IPs to a tracking file (for continuity)
#   - Add them to the existing repo_ips set.


NFT_SET="repo_ips"
TRACKING_FILE="/var/run/apt_ips.lst"

APT_SOURCES="/etc/apt/sources.list /etc/apt/sources.list.d/*.list"

PROXY_PORTS="3142"

# ensure tracking file exists and clean
: > "$TRACKING_FILE"

# Extract unique domains
DOMAINS=$( grep -hEo 'http[s]?://[^/ ]+' $APT_SOURCES | \
  sed -E 's|https?://||' | \
  cut -d/ -f1 | sort -u | \
  grep -v "$PROXY_PORTS"
)

# loop over domains
for domain in $DOMAINS; do

  # Resolve IPv4
  local ips=$( dig +short A "$domain" | sort -u )
  if [[ -n "$ips" ]]; then

    for ip in $ips; do

      # Add to tracking file only if not already there
      grep -qsF "$ip" "$TRACKING_FILE" || echo "$ip" >> "$TRACKING_FILE"
      # Add to nftables set (ignore error if already exists)
      nft add element inet filter $NFT_SET { $ip } 2>/dev/null

    done

  fi

done
