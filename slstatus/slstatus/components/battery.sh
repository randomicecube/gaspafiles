#!/usr/bin/sh
# Shamelessly stolen from RafDevX

OUT=''
LVL=$(cat /sys/class/power_supply/BAT1/capacity)

if [ "$LVL" -le 10 ]; then
	OUT="⛽"
elif [ "$LVL" -le 20 ]; then
	OUT=""
elif [ "$LVL" -le 40 ]; then
	OUT=""
elif [ "$LVL" -le 60 ]; then
	OUT=""
elif [ "$LVL" -le 80 ]; then
	OUT=""
else
	OUT=""
fi

OUT="$OUT $LVL%"

STATE=$(cat /sys/class/power_supply/BAT1/status)
if [ $STATE = "Charging" ]; then
  OUT="$OUT  " # charging
elif [ $STATE = "Discharging" ]; then
	OUT="$OUT  " # discharging
elif [ $STATE = "Idle" ]; then
  OUT="$OUT  " # idle
else
	OUT="$OUT  " # unknown
fi

echo $OUT
