#!/usr/bin/env bash

if pgrep "polybar" > /dev/null; then
    pkill -USR1 polybar
else
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload bar&
    done
fi

