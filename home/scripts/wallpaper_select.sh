#!/usr/bin/env bash

# swww transition config
FPS=60
TYPE="any"
DURATION=2
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION"

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/Pictures/wallpapers"

while true; do
	# List files in the wallpaper directory and send them to wofi
	SELECTED=$(ls "$WALLPAPER_DIR"/*.{png,jpg,jpeg,gif,webp} 2>/dev/null | xargs -n 1 basename | wofi --dmenu --prompt "Select a wallpaper:" -W 300 -H 300)

	# Check if a selection was made
	if [ -n "$SELECTED" ]; then
		# Set the selected wallpaper using swww
		#   swww img --transition-fps 60 --transition-type grow --transition-duration 2 --invert-y --transition-pos "$(hyprctl cursorpos | grep -E '^[0-9]' || echo "0,0")" "$WALLPAPER_DIR/$SELECTED"
		swww img ${SWWW_PARAMS} --invert-y --transition-pos "$(hyprctl cursorpos | grep -E '^[0-9]' || echo "0,0")" "$WALLPAPER_DIR/$SELECTED"
	else
		# Exit the loop if no selection is made (e.g., user closes wofi or presses ESC)
		break
	fi

	# Close menu without reprompting
	sleep 2
	break
done
