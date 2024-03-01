#!/usr/bin/env bash
#
# This script depends on iwctl, nmcli, libnotify and rofi.
# It displays a list of all available wifi networks and lets you pick which
# to connect to, prompting for a passphrase if needed.

notify-send "Getting list of available Wi-Fi networks..."

# Get the device and mode using iwctl.
device_and_mode=$(iwctl device list | sed '1,4d' | grep -v '^$' | tr -s " " | cut -d" " -f2- | awk '{print $1} {print $5}' | tr "\n" " ")
read -r device mode <<<"$device_and_mode"

# Scan the device.
iwctl "$mode" "$device" scan

# Wait some time so the scanned networks are discovered.
sleep 0.5

# List SSID of networks on the device.
networks=$(iwctl "$mode" "$device" get-networks)

# TODO: Identify networks that don't need authentication and give them a differenct icon.
#
# Check if we are connected to a network.
connected_network=""
if ! (echo "$networks" | sed -n '5p' | grep '>'); then
	sed_range="1,4d"
else
	# Treat connected network line specially because of the presence of '>' symbol.
	connected_network=$(echo "$networks" | sed -n '5p' | sed 's/\*\*.*//' | sed 's/^....................//g' | cut -d" " -f1- | awk '{$NF=""; print $0}' | sed 's/ $//')
	sed_range="1,5d"
fi

wifi_list=$(echo "$networks" | sed "$sed_range" | grep -v '^$' | sed 's/\*.*//' | sed 's/^....//g' | cut -d" " -f1- | awk '{$NF=""; print $0}' | sed 's/ $//')
test -n "$connected_network" && wifi_list="$connected_network\n$wifi_list"

wifi_radio=$(nmcli -fields WIFI g)
enable_wifi="󰖩 Enable Wi-Fi"
disable_wifi="󰖪 Disable Wi-Fi"

if [[ "$wifi_radio" =~ "enabled" ]]; then
	toggle=$disable_wifi
elif [[ "$wifi_radio" =~ "disabled" ]]; then
	toggle=$enable_wifi
fi

# Use rofi to select wifi network.
chosen_network=$(echo -e "$toggle\n$wifi_list" | uniq -u | rofi -dmenu -i -selected-row 1 -p "Wi-Fi SSID: ")

# Get name of connection without the preceeding symbol.
read -r chosen_id <<<"${chosen_network:2}"

if [ "$chosen_network" = "" ]; then
	exit
elif [ "$chosen_network" = "$enable_wifi" ]; then
	nmcli radio wifi on
elif [ "$chosen_network" = "$disable_wifi" ]; then
	nmcli radio wifi off
else
	# Message to show when connection is activated successfully.
	success_message="You are now connected to the Wi-Fi network $chosen_id."
	failure_message="Connection could not be established to $chosen_id."
	# Get saved connections.
	saved_connections=$(nmcli -g NAME connection)
	if [[ $(echo "$saved_connections" | grep -w "$chosen_id") = "$chosen_id" ]]; then
		if iwctl station "$device" connect "$chosen_id"; then
			notify-send "Connection Established" "$success_message"
		else
			notify-send "Failed" "$failure_message"
		fi
	else
		if [[ "$chosen_network" =~ "" ]]; then
			wifi_password=$(rofi -dmenu -p "Password: ")
		fi
		if iwctl --passphrase="$wifi_password" station "$device" connect "$chosen_id"; then
			notify-send "Connection Established" "$success_message"
		else
			notify-send "Failed" "$failure_message"
		fi
	fi
fi
