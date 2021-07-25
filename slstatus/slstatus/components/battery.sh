#!/usr/bin/sh
# Shamelessly stolen from RafDevX

OUT=''
LVL=$(cat /sys/class/power_supply/BAT1/capacity)

if [ "$LVL" -le 25 ]; then
	OUT=""
elif [ "$LVL" -le 50 ]; then
	OUT=""
elif [ "$LVL" -le 75 ]; then
	OUT=""
elif [ "$LVL" -le 90 ]; then
	OUT=""
else
	OUT=""
fi

OUT="$OUT $LVL%"

echo $OUT
