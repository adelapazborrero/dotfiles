#!/bin/sh

source $HOME/.config/sketchybar/colors.sh

IS_VPN=$(scutil --nwi | grep -m1 'utun' | awk '{ print $1 }')
LABEL="VPN"

if [[ $IS_VPN != "" ]]; then
	COLOR=$GREEN
	ICON=󰯅
else
    COLOR=$RED
    ICON=󰿆
fi

sketchybar --set $NAME icon="$ICON" icon.color="$COLOR" label="$LABEL" label.drawing=on
