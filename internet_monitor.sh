#!/bin/bash
LOG_FILE="./internet_status.log"

echo "Timestamp, Status, Ping (ms)" >> $LOG_FILE

while true; do
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
    PING_RESULT=$(ping -c 1 8.8.8.8 | grep "time=" | awk -F'time=' '{print $2}' | cut -d' ' -f1)

    if [ -z "$PING_RESULT" ]; then
        echo "$TIMESTAMP, DOWN, 0" >> $LOG_FILE
        echo "Internet is DOWN at $TIMESTAMP"
    else
        echo "$TIMESTAMP, UP, $PING_RESULT" >> $LOG_FILE
    fi

    sleep 10  # Checks every 10 seconds, adjust as needed
done
