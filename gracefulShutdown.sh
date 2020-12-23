#!/bin/sh

INTERFACE="eth0"
COUNTER=0
MINUTES=10

while true; do
    STATUS=`cat /sys/class/net/"$INTERFACE"/operstate`
    if [ "$STATUS" = "up" ]; then
        echo "ok"
        COUNTER=0
    else
        COUNTER=$((COUNTER+1))
        if [ "$COUNTER" -eq "$MINUTES" ]; then
            echo "graceful shutdown"
            sudo systemctl poweroff
        fi

        echo "Not connected to router for $COUNTER minute(s)"
    fi
    sleep 60
done
