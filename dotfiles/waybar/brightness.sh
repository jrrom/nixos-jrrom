#!/bin/bash

if [ -f ~/.config/waybar/brightness ]; then
	brightness=$(cat ~/.config/waybar/brightness)
else
	brightness=$(brightnessctl get)
fi

# Convert to percentage
percent=$((brightness * 100 / 255))

# Output as JSON
echo "{\"text\": \"$percent\", \"alt\": \"$percent\", \"tooltip\": \"$percent\", \"class\": \"brightness\", \"percentage\": $percent }"

