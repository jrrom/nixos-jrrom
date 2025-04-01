#!/bin/bash

# Managed by HSETC

# Read saved brightness value from config file
SAVED_VALUE=$(cat /home/jrrom/.config/waybar/brightnessctl/backlight/amdgpu_bl0)

# Set brightness using the raw value
if [ -n "$SAVED_VALUE" ]; then
    /usr/bin/brightnessctl set $SAVED_VALUE
else
    /usr/bin/brightnessctl set 50%
fi
