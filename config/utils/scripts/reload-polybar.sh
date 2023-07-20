#!/usr/bin/env bash

pkill -USR1 polybar
for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload bar&
done

