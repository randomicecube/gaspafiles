#!/usr/bin/sh
# Shamelessly stolen from RafDevX

OUT=''

#if [ "$(pulsemixer --id source-2 --get-mute)" = "1" ]; then
#	OUT="$OUT"
#else
#	OUT="$OUT"
#fi

if pamixer --get-mute > /dev/null; then
	OUT="$OUT "
elif [ $(pamixer --get-volume) -lt 50 ]; then
	OUT="$OUT "
else
	OUT="$OUT "
fi

OUT="$OUT $(pamixer --get-volume-human)"

#if [ "$(playerctl --player=spotify status)" = "Playing" ]; then
#	OUT="$OUT "
#else
#	OUT="$OUT "
#fi

echo $OUT
