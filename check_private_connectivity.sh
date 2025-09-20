#!/bin/bash

# Usage: ./check_private_connectivity.sh <TARGET_PRIVATE_IP> <PORT>
# Example: ./check_private_connectivity.sh 10.0.0.5 22

TARGET_IP=$1
PORT=$2

if [ -z "$TARGET_IP" ]; then
    echo "Error: Please provide the target private IP."
    exit 1
fi

# Optional: Check TCP port connectivity
if [ -n "$PORT" ]; then
    echo "Checking TCP connectivity to $TARGET_IP on port $PORT..."
    nc -zv $TARGET_IP $PORT
    if [ $? -eq 0 ]; then
        echo "TCP connection successful!"
    else
        echo "TCP connection failed!"
    fi
fi

# Ping check
echo "Pinging $TARGET_IP..."
ping -c 4 $TARGET_IP
if [ $? -eq 0 ]; then
    echo "Ping successful! Private connectivity verified."
else
    echo "Ping failed! Check firewall, NSG, or routing rules."
fi

