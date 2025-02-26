#!/bin/bash
LOG_FILE="./internet_speed.log"  # Log file in the project directory

# Add headers if the log file is empty
if [ ! -f "$LOG_FILE" ]; then
    echo "Timestamp, Ping (ms), Download (Mbps), Upload (Mbps)" > "$LOG_FILE"
fi

while true; do
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
    SPEED_RESULT=$(speedtest-cli --simple 2>&1)

    # Check if speed test output contains expected values
    if [[ "$SPEED_RESULT" == *"Cannot"* || "$SPEED_RESULT" == *"failed"* || -z "$SPEED_RESULT" ]]; then
        echo "$TIMESTAMP, DOWN, 0, 0" >> "$LOG_FILE"
        echo "[$TIMESTAMP] Internet DOWN - Speed test failed."
    else
        PING=$(echo "$SPEED_RESULT" | grep "Ping" | awk '{print $2}')
        DOWNLOAD=$(echo "$SPEED_RESULT" | grep "Download" | awk '{print $2}')
        UPLOAD=$(echo "$SPEED_RESULT" | grep "Upload" | awk '{print $2}')

        # Ensure values are not empty before logging
        if [[ -z "$PING" || -z "$DOWNLOAD" || -z "$UPLOAD" ]]; then
            echo "$TIMESTAMP, DOWN, 0, 0" >> "$LOG_FILE"
            echo "[$TIMESTAMP] Internet DOWN - Incomplete speed test result."
        else
            echo "$TIMESTAMP, $PING, $DOWNLOAD, $UPLOAD" >> "$LOG_FILE"
            echo "[$TIMESTAMP] Speed test successful: Ping=$PING ms, Download=$DOWNLOAD Mbps, Upload=$UPLOAD Mbps"
        fi
    fi

    sleep 180  # Runs every 3 minutes (adjustable)
done
