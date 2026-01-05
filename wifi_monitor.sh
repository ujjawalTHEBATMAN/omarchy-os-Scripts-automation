#!/bin/bash

# ================= CONFIGURATION =================
# LIST OF WIFI NAMES (SSIDs) IN ORDER OF PRIORITY
# 1. AYUUSHI25_5G
# 2. OnePlus NodeCE 5G
# 3. 5G
SSIDS=("AYUUSHI25_5G" "OnePlus NordCE 5G" "5G")

# LIST OF PASSWORDS (MUST MATCH THE ORDER ABOVE)
PASSWORDS=("admin@2222" "9824500878" "7990292020")

# How often to check (in seconds)
CHECK_INTERVAL=10
# =================================================

echo "Starting Multi-Priority Wi-Fi Monitor..."
echo "Priority Order: ${SSIDS[*]}"

while true; do
    CONNECTED=false

    # Loop through the list of SSIDs by index number (0, 1, 2...)
    for i in "${!SSIDS[@]}"; do
        CURRENT_SSID="${SSIDS[$i]}"
        CURRENT_PASS="${PASSWORDS[$i]}"

        # 1. Check if this specific network is available nearby
        # We use -t (terse) output to cleanly grep the SSID name
        IS_AVAILABLE=$(nmcli -t -f SSID dev wifi list | grep -x "$CURRENT_SSID")

        if [ -n "$IS_AVAILABLE" ]; then
            # The network is in range. Now check if we are ALREADY connected to it.
            IS_ACTIVE=$(nmcli -t -f ACTIVE,SSID dev wifi | grep "^yes:$CURRENT_SSID")

            if [ -n "$IS_ACTIVE" ]; then
                # We are already connected to the highest available priority.
                # Do nothing, just mark as connected and stop the loop.
                CONNECTED=true
                # echo "Stable on priority #$((i+1)): $CURRENT_SSID" # Uncomment for debug
                break 
            else
                # It is available, but we are NOT connected. 
                # Since the loop runs in priority order, we should connect to this one immediately.
                echo "$(date): Switching to higher priority network: $CURRENT_SSID..."
                
                nmcli device wifi connect "$CURRENT_SSID" password "$CURRENT_PASS"
                
                CONNECTED=true
                break # Stop checking lower priority networks
            fi
        fi
        # If not available, the loop continues to the next SSID in the list
    done

    if [ "$CONNECTED" = false ]; then
        echo "$(date): None of the preferred networks are in range."
    fi

    sleep $CHECK_INTERVAL
done

