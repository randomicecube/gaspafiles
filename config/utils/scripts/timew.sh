#! /usr/bin/env sh

# Prints whether or not there is current timetracking with timewarrior.
# Used in the polybar config

current_tracking="$($1 | head -n 1)"
if [ "$current_tracking" = "There is no active time tracking." ]; then
  icon="󰚭"
else
  icon="󱦟 $(echo $current_tracking | cut -c 10-)"
fi

echo $icon

