#!/usr/bin/env bash

wallpaperDir="$HOME/Pictures/wallpapers"

PICS=($(find -L ${wallpaperDir} -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \)))
if [ ${#PICS[@]} -eq 0 ]; then
	echo "No images found in {$wallpaperDir}"
	exit 1
fi

RANDOMPICS=${PICS[$RANDOM % ${#PICS[@]}]}

FPS=60
TYPE="random"
DURATION=1
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

# focused_monitor=$(hyprctl monitors | awk '/^Monitor/{name=$2} /focused: yes/{print name}')
# swww query || swww-daemon --format xrgb && swww img -o $focused_monitor ${RANDOMPICS} $SWWW_PARAMS
swww query || swww-daemon --format xrgb && swww img ${RANDOMPICS} $SWWW_PARAMS
