#!/bin/bash

# Retrieve Google Calendar ICS URL securely from pass
ICS_URL=$(pass calendar/ics-url)
ICS_FILE="/home/sid/.local/share/calendar/google_calendar.ics"

# Ensure the calendar directory exists
mkdir -p "$(dirname "$ICS_FILE")"

# Download the latest ICS file
curl -s -o "$ICS_FILE" "$ICS_URL"

# Check if `khal` is installed
if ! command -v khal &>/dev/null; then
    notify-send "Khal Not Found" "Please install khal to get calendar notifications."
    exit 1
fi

# Get upcoming events in the next hour
EVENTS=$(khal list now 1h)

# Send notifications for upcoming events
if [[ ! -z "$EVENTS" ]]; then
    echo "$EVENTS" | while IFS= read -r line; do
        notify-send "Upcoming Event" "$line"
    done
fi

