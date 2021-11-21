#!/bin/sh

killall -q polybar

polybar i3 -c ~/.config/polybar/config &
polybar i3_m2 -c ~/.config/polybar/config &

#polybar space -c ~/.config/polybar/workspace.ini &
#polybar primary -c ~/.config/polybar/workspace.ini &
#polybar top -c ~/.config/polybar/current.ini &
#polybar clock -c ~/.config/polybar/current.ini &