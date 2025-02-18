#!/usr/bin/env bash

if pgrep "polybar" > /dev/null; then
    pkill -u gaspa polybar
fi

for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload bar&
done

