#!/bin/bash
# Run in Termux or Android shell

current_time=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
mkdir -p /storage/emulated/0/DeadHand
cat > /storage/emulated/0/DeadHand/auth.json <<EOF
{
  "key": "DEADHAND_AUTH_CODE_2006",
  "timestamp": "$current_time"
}
EOF
echo "auth.json token created with current UTC time."
