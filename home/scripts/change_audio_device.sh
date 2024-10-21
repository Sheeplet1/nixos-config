#!/usr/bin/env bash

# Get the current default sink
current_sink=$(pactl get-default-sink)

# Define the sinks
g560_sink="alsa_output.usb-Logitech_G560_Gaming_Speaker_00000000-00.analog-stereo"
# analog_sink="alsa_output.pci-0000_09_00.4.analog-stereo.2"
analog_sink=$(pactl list short sinks | grep 'alsa_output.pci-0000_09_00.4.analog-stereo' | awk '{print $2}')

move_running_inputs() {
	local new_sink=$1
	local inputs=$(pactl list short sink-inputs | grep RUNNING | cut -f1)
	for input in $inputs; do
		pactl move-sink-input "$input" "$new_sink"
	done
}

# Toggle the sink
if [ "$current_sink" == "$g560_sink" ]; then
	echo "Switching to $analog_sink"
	pactl set-default-sink "$analog_sink"
	move_running_inputs "$analog_sink"
	# pactl move-sink-input "$(pactl list short sink-inputs | grep RUNNING | cut -f1)" "$analog_sink"
else
	echo "Switching to $g560_sink"
	pactl set-default-sink "$g560_sink"
	move_running_inputs "$g560_sink"
	# pactl move-sink-input "$(pactl list short sink-inputs | grep RUNNING | cut -f1)" "$g560_sink"
fi
