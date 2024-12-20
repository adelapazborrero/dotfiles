#!/bin/sh

# The wifi_change event supplies a $INFO variable in which the current SSID
# is passed to the script.

source $HOME/.config/sketchybar/colors.sh

WIFI=${INFO:-"Not Connected"}
WIFI=$(/Sy*/L*/Priv*/Apple8*/V*/C*/R*/airport -I | grep -w SSID | awk '{print $2}')

sketchybar --set $NAME label="${WIFI}" icon.color="$COLOR12"
