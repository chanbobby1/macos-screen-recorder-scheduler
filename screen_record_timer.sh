#!/bin/bash

# --- PARAMETERS ---
# Usage: ./screen_record_timer.sh [duration_secs] [start_time_hh:mm]
# Examples: 
#   ./screen_record_timer.sh 30          (Starts NOW, records for 30s)
#   ./screen_record_timer.sh 3600 23:30  (Starts at 11:30 PM, records for 1hr)

DURATION=${1:-60}  # Defaults to 60 seconds
START_TIME=$2      # Optional second parameter

# --- DELAY LOGIC ---
if [ -n "$START_TIME" ]; then
    CURRENT_EPOCH=$(date +%s)
    # Target time on the current day
    TARGET_EPOCH=$(date -j -f "%H:%M" "$START_TIME" +%s)
    
    # If the time has already passed today, assume tomorrow
    if [ "$TARGET_EPOCH" -lt "$CURRENT_EPOCH" ]; then
        TARGET_EPOCH=$((TARGET_EPOCH + 86400))
    fi
    
    SLEEP_SECONDS=$((TARGET_EPOCH - CURRENT_EPOCH))
    
    echo "Local Time: $(date +%T)"
    echo "Waiting $SLEEP_SECONDS seconds to start at $START_TIME..."
    sleep "$SLEEP_SECONDS"
fi

# --- THE RECORDING LOGIC ---
DEST_FOLDER="$HOME/Movies"
FINAL_NAME="Recording_$(date +%Y%m%d_%H%M%S).mov"
SAVE_PATH="$DEST_FOLDER/$FINAL_NAME"

echo "Step 1: Starting Recording..."
osascript <<EOT
tell application "QuickTime Player"
    activate
    delay 1
    tell application "System Events" to tell process "QuickTime Player"
        if exists window "Open" then keystroke (ASCII character 27)
        click menu item "New Screen Recording" of menu "File" of menu bar 1
        delay 2
        keystroke return
    end tell
end tell
EOT

echo "Step 2: Recording for $DURATION seconds..."
sleep "$DURATION"

echo "Step 3: Signaling stop..."
pkill -INT "screencaptureui"

echo "Step 4: Locating and moving the file..."
sleep 5
RECENT_FILE=$(find "$HOME/Desktop" "$HOME/Movies" -name "Screen Recording*.mov" -mmin -2 | head -n 1)

if [ -n "$RECENT_FILE" ]; then
    mv "$RECENT_FILE" "$SAVE_PATH"
    echo "Success! File moved to: $SAVE_PATH"
else
    echo "Error: Could not find the system-saved file."
fi

# Close QuickTime to reset for the next run
osascript -e 'tell application "QuickTime Player" to quit'