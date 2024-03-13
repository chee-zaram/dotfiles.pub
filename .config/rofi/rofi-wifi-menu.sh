#!/usr/bin/env bash

DEPENDENCIES=("iwctl" "nmcli" "notify-send" "rofi")
DEVICE=""
MODE=""
CHOSEN_NETWORK=""
WIFI_LIST=""
TOGGLE="󰖩 Enable Wi-Fi"

for dep in "${DEPENDENCIES[@]}"; do
  if ! command -v "$dep" &>/dev/null; then
    echo "Error: $dep is not installed. Please install it before running this script."
    echo "All dependencies: ${DEPENDENCIES[*]}"
    exit 1
  fi
done

is_wifi_enabled() {
  [[ $(nmcli -fields WIFI g) =~ "enabled" ]]
}

# toggle_wifi enables or disables Wi-Fi using nmcli.
toggle_wifi() {
  if is_wifi_enabled; then
    nmcli radio wifi off
  else
    nmcli radio wifi on
  fi
}

# notify_user displays notification by using notify-send under the hood.
# It takes 2 arguments to be passed to notify-send.
notify_user() {
  notify-send "$1" "$2"
}

# get_mode_and_device sets the values of DEVICE and MODE for global use.
get_mode_and_device() {
  local iwctl_output
  iwctl_output=$(iwctl device list | awk 'NR > 4 {print $2, $6}')

  DEVICE=$(echo "$iwctl_output" | awk '{print $1}')
  MODE=$(echo "$iwctl_output" | awk '{print $2}')

  iwctl "$MODE" "$DEVICE" scan >/dev/null 2>&1
  sleep 0.5 # sleep allows some time for scanning to happen.
}

# get_wifi_list returns a list of SSIDs to be displayed with some icons.
get_wifi_list() {
  local networks
  networks=$(iwctl "$MODE" "$DEVICE" get-networks)

  # TODO: Identify networks that don't need authentication and give them a differenct icon.
  #
  # Check if we are connected to a network.
  local connected_network
  connected_network=""
  if [[ ! $(echo "$networks" | sed -n '5p') =~ ">" ]]; then
    sed_range="1,4d"
  else
    # Treat connected network line specially because of the presence of '>' symbol.
    connected_network=$(echo "$networks" | sed -n '5p' | sed 's/\*\*.*//' | sed 's/^....................//g' | cut -d" " -f1- | awk '{$NF=""; print $0}' | sed 's/ $//' | grep -v '^$')
    sed_range="1,5d"
  fi

  local wifi_list
  wifi_list=$(echo "$networks" | sed "$sed_range" | sed 's/\*.*//' | sed 's/^....//g' | cut -d" " -f1- | awk '{$NF=""; print $0}' | sed 's/ $//' | grep -v '^$')
  test -n "$connected_network" && echo -e "$connected_network\n$wifi_list"
}

get_wifi_password() {
  rofi -dmenu -p "Password: "
}

# Main logic
notify_user "Getting list of available Wi-Fi networks..." ""

get_mode_and_device
WIFI_LIST=$(get_wifi_list)

if is_wifi_enabled; then
  TOGGLE="󰖪 Disable Wi-Fi"
fi

CHOSEN_NETWORK=$(echo -e "$TOGGLE\n$WIFI_LIST" | uniq -u | rofi -dmenu -i -selected-row 1 -p "Wi-Fi SSID: ")

if [[ -z "$CHOSEN_NETWORK" ]]; then
  exit
elif [[ "$CHOSEN_NETWORK" == "$TOGGLE" ]]; then
  toggle_wifi
  notify_user "Wi-Fi Toggled" "Wi-Fi is now $(is_wifi_enabled && echo 'enabled' || echo 'disabled')."
# elif is_wifi_enabled; then
else
  # Get name of connection without the preceeding symbol.
  read -r CHOSEN_ID <<<"${CHOSEN_NETWORK:2}"

  success_message="You are now connected to the Wi-Fi network $CHOSEN_ID."
  failure_message="Connection to $CHOSEN_ID could not be established."
  saved_connections=$(nmcli -g NAME connection)

  if [[ $(echo "$saved_connections" | grep -w "$CHOSEN_ID") = "$CHOSEN_ID" ]]; then
    if iwctl "$MODE" "$DEVICE" connect "$CHOSEN_ID"; then
      notify_user "Connection Established" "$success_message"
    else
      notify_user "Failed" "$failure_message"
    fi
  else
    # test "$CHOSEN_NETWORK" =~ "" && wifi_password=$(get_wifi_password)
    wifi_password=$(get_wifi_password)
    if iwctl --passphrase="$wifi_password" "$MODE" "$DEVICE" connect "$CHOSEN_ID"; then
      notify_user "Connection Established" "$success_message"
    else
      notify_user "Failed" "$failure_message"
    fi
  fi
fi
