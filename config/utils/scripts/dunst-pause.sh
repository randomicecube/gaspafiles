#! /usr/bin/env sh

# Module showing if dunst is paused and if so, how many notifications are pending
# Icon is ommited if not paused

DUNST=$1
PATH=$PATH:$2

OUT=""

if [ "$($DUNST is-paused)" = "true" ]; then
  OUT="󰂛"
  WAITING="$($DUNST count waiting)"
  if [ $WAITING != 0 ]; then
    OUT="$OUT ($WAITING)"
  fi
fi

echo $OUT

