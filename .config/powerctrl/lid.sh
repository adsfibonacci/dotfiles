#!/bin/bash

# -------- Configuration --------
LAPTOP_PANEL="LVDS-1"

# -------- State detection --------
LID_STATE=$(awk '{print $2}' /proc/acpi/button/lid/LID*/state)
ON_AC=$(grep -q 1 /sys/class/power_supply/AC*/online 2>/dev/null && echo yes || echo no)

EXTERNAL_CONNECTED=$(swaymsg -t get_outputs -r \
  | jq -r '.[] | select(.name != "'"$LAPTOP_PANEL"'") | select(.active == true) | .name' \
  | wc -l)

# -------- Logic --------
if [[ "$LID_STATE" == "closed" ]]; then
    if [[ "$ON_AC" == "no" && "$EXTERNAL_CONNECTED" -eq 0 ]]; then
        systemctl poweroff
    else
        swaylock -f
    fi
else
    if [[ "$EXTERNAL_CONNECTED" -gt 0 ]]; then
        swaymsg output "$LAPTOP_PANEL" disable
    else
        swaymsg output "$LAPTOP_PANEL" enable
    fi
fi
