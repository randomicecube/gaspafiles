#!/usr/bin/env bash

MONITORS=$(xrandr --query | grep " connected" | cut -d" " -f1)
MONITOR_COUNT=$(echo $MONITORS | wc -w)

if [ $MONITOR_COUNT -eq 1 ]; then
    xrandr --output $MONITORS --primary --mode 1920x1080 --pos 0x0 --rotate normal
    exit 0
fi

XRANDR_COMMAND="xrandr"

# eDP-1, if it exists, must be the primary monitor
if [[ $MONITORS == *"eDP-1"* ]]; then
    MONITORS=$(echo $MONITORS | sed 's/eDP-1//g')
    XRANDR_COMMAND="$XRANDR_COMMAND --output eDP-1 --primary --mode 1920x1080 --pos 0x1080 --rotate normal"
fi

# if there's another monitor, it should be positioned above the primary monitor
# for simplicity, we'll assume there's only one other monitor
if [ $MONITOR_COUNT -eq 2 ]; then
    XRANDR_COMMAND="$XRANDR_COMMAND --output $MONITORS --mode 1920x1080 --pos 0x0 --rotate normal"
fi
