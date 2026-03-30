#!/bin/bash
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost/health)
if [ "$RESPONSE" = "200" ]; then
  echo "$TIMESTAMP OK $RESPONSE" >> /var/log/health_check.log
else
  echo "$TIMESTAMP FAIL $RESPONSE" >> /var/log/health_check.log
fi
